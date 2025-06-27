import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/add_service_details/select_service.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/helper/global_helper.dart';


class AddServiceDetailsScreen extends StatefulWidget {
  const AddServiceDetailsScreen({super.key});

  @override
  State<AddServiceDetailsScreen> createState() =>
      _AddServiceDetailsScreenState();
}

class _AddServiceDetailsScreenState extends State<AddServiceDetailsScreen> {
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String dropdownValue = "Category";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Service Details",
          onPress: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const CustomText(
                text: "Service Details",
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                isPoppins: true,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const CustomText(
                text:
                    "You’ll be able to add a description and adjust advanced settings",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                isPoppins: true,
              ),
            ),
            20.verticalSpace,
            Column(
              children: [
                // 30.verticalSpace,
                // topHeader(context),

                10.verticalSpace,
                CustomTextField(
                  controller: serviceNameController,
                  hintText: "Activity Name",
                  textFontSize: 14,
                  hintTextColor: Colors.black,
                  fontWeight: FontWeight.w400,
                ),

                20.verticalSpace,
                CustomTextField(
                  controller: durationController,
                  hintText: "Duration",
                  textFontSize: 14,
                  hintTextColor: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                20.verticalSpace,
                CustomTextField(
                  controller: priceController,
                  hintText: "Price-\$",
                  textFontSize: 14,
                  hintTextColor: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                70.verticalSpace,

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    buttonText: "+Add",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    onPressed: submitServiceDetails,
                  ),

                ),
              ],
            ),
            10.verticalSpace,

            // 50.verticalSpace,
            // const Spacer(),

            // Stack(
            //   children: [
            //     Positioned(
            //         bottom: 25,
            //         child: SvgPicture.asset(AppImages.bottomMiddleRoundRing)),
            //   ],
            // )
          ],
        ),
      ),
    );
  }



  /*Future<void> submitServiceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('token dans service details $token');

    final name = serviceNameController.text.trim();
    final duration = durationController.text.trim();
    final price = priceController.text.trim();

    if (name.isEmpty || duration.isEmpty || price.isEmpty) {
      GlobalHelper.showErrorSnackbar(context, "Tous les champs sont requis.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8000/api/coach/services'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "name": name,
          "duration": duration,
          "price": price,
        }),
      );

      print('code: ${response.statusCode}');
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("data $data");
        if (data['status'] == true) {
          print("Redirection vers SelectServiceScreen");
          GlobalHelper.showSuccessSnackbar(context, "Service ajouté !");
          PageNavigator(ctx: context).nextPage(page: const SelectServiceScreen());
        } else {
          GlobalHelper.showErrorSnackbar(context, data['message'] ?? "Erreur inconnue");
        }
      } else {
        GlobalHelper.showErrorSnackbar(context, data['message'] ?? "Erreur serveur");
      }
    } catch (e) {
      GlobalHelper.showErrorSnackbar(context, "Erreur : $e");
    }
  }*/

  Future<void> submitServiceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    //print('token dans service details $token');

    final name = serviceNameController.text.trim();
    final duration = durationController.text.trim();
    final price = priceController.text.trim();

    if (name.isEmpty || duration.isEmpty || price.isEmpty) {
      GlobalHelper.showErrorSnackbar(context, "Tous les champs sont requis.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8000/api/coach/services'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "name": name,
          "duration": duration,
          "price": price,
        }),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      print("Réponse API: $data");

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (data['status'] == true) {
          GlobalHelper.showSuccessSnackbar(context, "Service ajouté !");
          PageNavigator(ctx: context).nextPage(page: const SelectServiceScreen());
        } else {
          GlobalHelper.showErrorSnackbar(context, data['message'] ?? "Erreur inconnue");
        }
      } else {
        // Gérer cas où l'API renvoie une erreur métier (ex: durée dépassée)
        GlobalHelper.showErrorSnackbar(context, data['message'] ?? "Erreur serveur");
      }
    } catch (e) {
      GlobalHelper.showErrorSnackbar(context, "Erreur : $e");
    }
  }




}

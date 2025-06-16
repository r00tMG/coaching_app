import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/onboarding/coach_location.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/dropdown/custom_dropdown.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String dropdownValue = "Category";
  final List<String> categories = [
    "Category",
    "Fitness",
    "Musculation",
    "Cardio-training",
    "CrossFit",
    "Yoga",
    "Pilates",
    "Running",
    "Cyclisme",
    "Natation",
    "Boxe",
    "Arts martiaux",
    "Danse",
    "Escalade",
    "Triathlon",
    "Athlétisme",
    "Golf",
    "Tennis",
    "Rugby",
    "Football",
    "Basketball",
    "Volleyball",
    "Surf",
    "Ski/Snowboard",
    "Aviron",
    "Escrime",
    "Handball",
    "Marche nordique",
    "Équitation",
    "Randonnée",
    "Arts du cirque",
    "Stretching",
    "Méditation",
    "Nutrition sportive",
    "Coach de vie"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Service Details",
          onPress: () {
            Navigator.pop(context);
          }),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [SvgPicture.asset(AppImages.bottomMiddleRoundRing)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  hintText: "Service Name",
                  textFontSize: 14,
                  hintTextColor: Colors.black,
                  fontWeight: FontWeight.w400,
                ),

                10.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomDropdown(
                      backgroundColor: AppColors.white,
                      items: categories,
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        }
                      }
                  ),
                ),
                10.verticalSpace,
                CustomTextField(
                  keyboardType: TextInputType.multiline,
                  controller: nameController,
                  hintText: "Description",
                  hintTextColor: Colors.black,
                  maxLines: 5,
                ),
                70.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      buttonText: "Continue",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      /* onPressed: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const CoachLocation());
                      }), */
                      onPressed: () {
                      registerService(
                        serviceName: serviceNameController.text.trim(),
                        category: dropdownValue,
                        description: nameController.text.trim(),
                        context: context,
                      );
                    }),
                ),
              ],
            ),
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

  Future<void> registerService({
    required String serviceName,
    required String category,
    required String description,
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('token dans service details $token');

    final response = await http.post(
      Uri.parse('http://0.0.0.0:8000/api/services'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'service_name': serviceName,
        'category': category,
        'description': description,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print('Service enregistré : ${data['service']}');
      // navigation vers la page suivante
      PageNavigator(ctx: context).nextPage(page: const CoachLocation());
    } else {
      print('Erreur : ${data['message']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${data['message']}')),
      );
    }
  }

}

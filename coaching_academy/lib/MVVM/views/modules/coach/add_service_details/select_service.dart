import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/dashboard/coach_dashboard.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../utils/helper/global_helper.dart';
import 'edit_service_screen.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String dropdownValue = "Category";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Booking",
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
                text: "Please select the service",
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                isPoppins: true,
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  20.verticalSpace,
                  ...services.map((service) => selectServiceButton(service)).toList(),
                  10.verticalSpace,
                  /*selectServiceButton(),
                  10.verticalSpace,
                  selectServiceButton(),
                  10.verticalSpace,
                  selectServiceButton(),
                  10.verticalSpace,
                  selectServiceButton()*/
                ],
              ),
            ),
            70.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  buttonText: "+Add",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  buttonText: "Continue",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const CoachDashboard());
                  }),
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

  /*Container selectServiceButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Column(
                children: [
                  CustomText(
                    text: "Yoga",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    isPoppins: true,
                    color: Colors.black,
                  ),
                  CustomText(
                    text: "60 Min",
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    isPoppins: true,
                    color: Color(0xffb4b4b4),
                  ),
                ],
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const CustomText(
                text: "Edit",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                isPoppins: true,
              ))
        ],
      ),
    );
  }*/


  List<dynamic> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  Future<void> fetchServices() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    try {
      final response = await http.get(
        Uri.parse('http://0.0.0.0:8000/api/coach/services'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          services = data['services']; // ou 'data' selon ta réponse backend
        });
      } else {
        GlobalHelper.showErrorSnackbar(context, "Erreur de chargement des services.");
      }
    } catch (e) {
      GlobalHelper.showErrorSnackbar(context, "Erreur : $e");
    }
  }


  Container selectServiceButton(dynamic service) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: service['name'] ?? 'Nom inconnu',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                isPoppins: true,
                color: Colors.black,
              ),
              CustomText(
                text: "${service['duration']} Min",
                fontSize: 11,
                fontWeight: FontWeight.w400,
                isPoppins: true,
                color: const Color(0xffb4b4b4),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditServiceScreen(serviceId: service['id']),
                ),
              );

              // Rafraîchir les données si un service a été modifié
              if (result == true) {
                fetchServices();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const CustomText(
              text: "Edit",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              isPoppins: true,
            ),
          )
        ],
      ),
    );
  }



}

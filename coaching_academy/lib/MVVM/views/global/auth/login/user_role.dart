import 'package:coaching_academy/MVVM/views/global/auth/login/widget/user_role_widget.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/onboarding/service_details.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/sporty_dashboard.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/subscription/subscription_step1.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class UserRoleScreen extends StatefulWidget {
  const UserRoleScreen({super.key});

  @override
  State<UserRoleScreen> createState() => _UserRoleScreenState();
}

class _UserRoleScreenState extends State<UserRoleScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              buttonText: "Continue",
              /* onPressed: () {
                if (selectedIndex == -1) {
                  showToast(context: context, message: "Please select a role!");
                } else if (selectedIndex == 0) {
                  PageNavigator(ctx: context)
                      .nextPage(page: const SportyDashboard());
                } else {
                  PageNavigator(ctx: context)
                      .nextPage(page: const ServiceDetailsScreen());
                }
              }, */
              onPressed: () async {
                if (selectedIndex == -1) {
                  showToast(context: context, message: "Please select a role!");
                  return;
                }

                final role = selectedIndex == 0 ? 'sporty' : 'coach';
                
                final token = await getToken();
                print("token on user_role page $token");

                if (token == null) {
                  showToast(context: context, message: "User not authenticated");
                  return;
                }

                await setUserRole(role, token, context);

                if (selectedIndex == 0) {
                  PageNavigator(ctx: context).nextPage(page: const SportyDashboard());
                } else {
                  //PageNavigator(ctx: context).nextPage(page: const ServiceDetailsScreen());
                  PageNavigator(ctx: context).nextPage(page: const SubscriptionStep1());
                }
              },

              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 40),
                  child: SvgPicture.asset(AppImages.rectangleDots)),
              SvgPicture.asset(AppImages.roundRingBottom),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      AppImages.roundCircleRightIcon,
                    ),
                  ],
                ),
                const CustomText(
                  text: "Select your user role",
                  fontSize: 19,
                  isPoppins: true,
                  fontWeight: FontWeight.w700,
                ),
                10.verticalSpace,
                const GreyCustomText(
                  text:
                      "Identify your role to customize your Sport experience, whether you’re seeking support, offering therapy, or managing wellness benefits",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  isPoppins: true,
                ),
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: UserRoleWidget(
                        imagePath: AppImages.sportyIcon,
                        title: "Join as Sporty",
                        isSelected: selectedIndex == 0,
                      ),
                    ),
                    20.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: UserRoleWidget(
                        imagePath: AppImages.coachIcon,
                        title: "Join as Coach",
                        isSelected: selectedIndex == 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> setUserRole(String role, String token, BuildContext context) async {
    final url = Uri.parse('http://localhost:8000/api/set-role');

    try {
      //print('salut user role');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'role': role}),
      );

      if (response.statusCode == 200) {
        //print('Role saved');
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('role', jsonEncode(data['role']));
        showToast(context: context, message: "Role saved!");

        /*final body = jsonDecode(response.body);
        if (body['onboarding_url'] != null) {
          final url = body['onboarding_url'];
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          } else {
            showToast(context: context, message: "Impossible d'ouvrir le lien Stripe");
          }
        }*/

      } else {
        //print('failed to set Role');
        showToast(context: context, message: "Failed to set role");
      }
    } catch (e) {
      print('error try/catch');
      showToast(context: context, message: "Erreur : $e");
    }
  }

}

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/sporty_dashboard2.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:coaching_academy/utils/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Set Your Location",
          onPress: () {
            Navigator.pop(context);
          }),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
                buttonText: "Continue",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                onPressed: () async {
                  if (controller.text.isEmpty) {
                    showToast(
                        context: context, message: "Please enter the city");
                  } else {
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // prefs.setString('myLocation', controller.text);
                    PageNavigator(ctx: context).nextPage(
                        page: const SportyDashboard2(
                      indexx: 0,
                    ));
                  }
                  // PageNavigator(ctx: context)
                  //     .nextPage(page: const SignupStep3());
                }),
          ),
          40.verticalSpace,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Location",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: "Where do you work most often?",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            // 50.verticalSpace,
            // const Spacer(),
            10.verticalSpace,
            CustomTextField(
                borderType: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                labelStyle: GoogleFonts.poppins(),
                label: const CustomText(
                  text: "City",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                controller: controller,
                hintText: "Enter Your City"),

            // 70.verticalSpace,

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
}

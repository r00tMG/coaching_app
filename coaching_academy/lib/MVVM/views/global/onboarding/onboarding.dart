import 'package:coaching_academy/MVVM/views/global/auth/register/signup_screen.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppImages.roundRingTop),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppImages.roundCircle),
                SvgPicture.asset(AppImages.rightCurve),
              ],
            ),
            20.verticalSpace,
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  AppImages.handshake,
                  fit: BoxFit.cover,
                )),
            15.verticalSpace,
            const Center(
              child: CustomText(
                isPoppins: true,
                text: "Welcome to TREENER",
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const CustomText(
                isPoppins: true,
                text:
                    "Embark on a journey to enhanced well-being with Business Health, your gateway to personalized mental health support and resources",
                textAlign: TextAlign.center,
                color: Color(0xffa1a1a1),
              ),
            ),
            30.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                buttonText: "Get Started",
                onPressed: () {
                  PageNavigator(ctx: context).nextPage(
                    page: const SignupScreen(),
                  );
                },
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppImages.roundRingBottom),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:coaching_academy/MVVM/views/global/auth/forgot_password/forgot_password_step2.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordStep1 extends StatefulWidget {
  const ForgotPasswordStep1({super.key});

  @override
  State<ForgotPasswordStep1> createState() => _ForgotPasswordStep1State();
}

class _ForgotPasswordStep1State extends State<ForgotPasswordStep1> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(AppImages.rectangleDots),
                  ],
                ),
              ),
              SvgPicture.asset(AppImages.forgotPassword),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(AppImages.rightSimpleCurve),
                    ],
                  ),
                  Positioned(
                    top: 50,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Row(
                        children: [
                          CustomText(
                            text: "Forgot Password",
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: const EdgeInsets.only(left: 20),
                      child: const GreyCustomText(
                        text:
                            "Enter your email or phone no. so that we can send you an OTP code to reset your password",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              40.verticalSpace,
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Row(
                  children: [
                    CustomText(
                      text: "Email or Phone Number",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      isPoppins: true,
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              CustomTextField(
                  iconPath: AppImages.emailIcon,
                  iconColor: AppColors.backgroundGrey,
                  suffixIcon: SvgPicture.asset(
                    AppImages.checkCircleBlack,
                    fit: BoxFit.scaleDown,
                  ),
                  controller: emailController,
                  hintText: "Alexa786@gmail.com"),
              90.verticalSpace,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    buttonText: "Continue",
                    onPressed: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const ForgotPasswordStep2());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

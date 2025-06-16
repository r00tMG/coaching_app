import 'package:coaching_academy/MVVM/views/global/auth/login/login_screen.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordStep3 extends StatefulWidget {
  const ForgotPasswordStep3({super.key});

  @override
  State<ForgotPasswordStep3> createState() => _ForgotPasswordStep3State();
}

class _ForgotPasswordStep3State extends State<ForgotPasswordStep3> {
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
              20.verticalSpace,
              SvgPicture.asset(AppImages.forgotPasswordSuccess),
              50.verticalSpace,
              const CustomText(
                text: "Reset Successfully",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                isPoppins: true,
              ),
              5.verticalSpace,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const CustomText(
                  text:
                      "Your password has been successfully reset. You can now log in with your new password.",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  isPoppins: true,
                  // textAlign: TextAlign.center,
                ),
              ),
              40.verticalSpace,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    buttonText: "Continue",
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }), (v) => false);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

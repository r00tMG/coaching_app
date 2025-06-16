import 'dart:async';

import 'package:coaching_academy/MVVM/views/global/auth/forgot_password/forgot_password_step3.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordStep2 extends StatefulWidget {
  const ForgotPasswordStep2({super.key});

  @override
  State<ForgotPasswordStep2> createState() => _ForgotPasswordStep2State();
}

class _ForgotPasswordStep2State extends State<ForgotPasswordStep2> {
  TextEditingController emailController = TextEditingController();
  Timer? _timer;
  int _start = 30;

  TextEditingController pinController =
      TextEditingController(); // Timer starts from 30 seconds

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer?.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Dispose of the timer when the widget is destroyed
    super.dispose();
  }

  String get timerText {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

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
                            text: "OTP Verification",
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
                            "Enter the One-Time Password (OTP) sent to your email or mobile to proceed.",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              40.verticalSpace,
              10.verticalSpace,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  enablePinAutofill: true,
                  hintCharacter: "",
                  autoDisposeControllers: false,
                  hintStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  appContext: context,
                  keyboardType: TextInputType.number,
                  length: 4, // Length of the OTP
                  controller: pinController,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    activeBorderWidth: 1,
                    inactiveBorderWidth: 1,
                    fieldWidth: 70,
                    fieldHeight:
                        60, // Reduced the field width to bring fields closer
                    borderRadius: BorderRadius.circular(10),
                    shape: PinCodeFieldShape.box,
                    selectedColor:
                        Colors.grey, // Border color for selected field
                    activeColor: Colors.grey, // Border color for active field
                    inactiveColor:
                        Colors.grey, // Border color for inactive field
                    borderWidth: 1.0,

                    // Set the fill colors to white
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  enableActiveFill: true, // To fill the background color
                  onChanged: (value) {
                    // Handle OTP change
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "$timerText sec",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              90.verticalSpace,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    buttonText: "Verify",
                    onPressed: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const ForgotPasswordStep3());
                    }),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "Don’t receive code?",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    isPoppins: true,
                  ),
                  2.horizontalSpace,
                  const CustomText(
                    text: "Re-send",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    isPoppins: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

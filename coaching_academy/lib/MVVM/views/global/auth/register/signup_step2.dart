import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/global/auth/login/login_screen.dart';
import 'package:coaching_academy/MVVM/views/global/auth/register/signup_step3.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/button/custom_outline_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'auth_service.dart';

class SignupScreenStep2 extends StatefulWidget {
  const SignupScreenStep2({super.key});

  @override
  State<SignupScreenStep2> createState() => _SignupScreenStep2State();
}

class _SignupScreenStep2State extends State<SignupScreenStep2> {
  final TextEditingController bioController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithArrow(context: context),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [SvgPicture.asset(AppImages.bottomMiddleRoundRing)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // 30.verticalSpace,
                // topHeader(context),
                50.verticalSpace,
                filterHeading("Introduction"),
                10.verticalSpace,
                CustomTextField(
                  keyboardType: TextInputType.multiline,
                  controller: bioController,
                  hintText: "Enter your bio",
                  maxLines: 3,
                ),
                20.verticalSpace,
                filterHeading("Password"),
                10.verticalSpace,
                CustomTextField(
                  iconPath: AppImages.passwordIcon,
                  controller: passwordController,
                  hintText: "Enter your password",
                  isObscure: true,
                  maxLines: 1,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: const GreyCustomText(
                    text:
                        "Password must include both uppercase and lowercase characters, and at least one number.",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                20.verticalSpace,
                filterHeading("Confirm Password"),
                10.verticalSpace,
                CustomTextField(
                  iconPath: AppImages.passwordIcon,
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  isObscure: true,
                  maxLines: 1,
                ),
                50.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                      buttonText: "Continue",
                      /*onPressed: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const SignupStep3());
                      }*/
                      onPressed: () async {
                        final bio = bioController.text.trim();
                        final password = passwordController.text.trim();
                        final confirmPassword = confirmPasswordController.text.trim();

                        if (bio.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill all fields")),
                          );
                          return;
                        }

                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Passwords do not match")),
                          );
                          return;
                        }

                        final success = await AuthService.completeSignup(
                          bio: bio,
                          password: password,
                        );

                        if (success) {
                          PageNavigator(ctx: context).nextPage(page: const SignupStep3());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("An error occurred. Please try again.")),
                          );
                        }
                      }

                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 100, child: Divider()),
                    5.horizontalSpace,
                    const GreyCustomText(
                      text: "Have an account?",
                    ),
                    5.horizontalSpace,
                    const SizedBox(width: 100, child: Divider()),
                  ],
                ),
                20.verticalSpace,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutlineButton(
                      buttonText: "Signin",
                      onPressed: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const LoginScreen());
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
}

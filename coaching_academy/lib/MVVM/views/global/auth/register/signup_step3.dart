import 'package:coaching_academy/MVVM/views/global/auth/login/login_screen.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'auth_service.dart';

/*class SignupStep3 extends StatelessWidget {
  const SignupStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [SvgPicture.asset(AppImages.bottomLeftRoundRing)],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/congrats_like.png"),
            20.verticalSpace,
            const CustomText(
              text: "Congratulations!",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const GreyCustomText(
                text:
                    "Your profile has been approved! You're now ready to explore and engage.",
                fontSize: 13,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ),
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonText: "login",
                onPressed: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: const LoginScreen());
                },
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
class SignupStep3 extends StatefulWidget {
  const SignupStep3({super.key});

  @override
  State<SignupStep3> createState() => _SignupStep3State();
}

class _SignupStep3State extends State<SignupStep3> {
  @override
  void initState() {
    super.initState();
    finalizeRegistration();
  }

  Future<void> finalizeRegistration() async {
    final success = await AuthService.finalizeSignup();
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not finalize registration")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [SvgPicture.asset(AppImages.bottomLeftRoundRing)],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/congrats_like.png"),
            20.verticalSpace,
            const CustomText(
              text: "Congratulations!",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const GreyCustomText(
                text:
                "Your profile has been approved! You're now ready to explore and engage.",
                fontSize: 13,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ),
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonText: "Login",
                onPressed: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: const LoginScreen());
                },
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

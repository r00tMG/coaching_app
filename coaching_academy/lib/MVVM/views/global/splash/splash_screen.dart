import 'package:coaching_academy/MVVM/views/global/onboarding/onboarding.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();

    // initSharedPreferences();
    navigateToOnboarding();
  }

// will be used to navigate to onboarding only first time
  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs!.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      prefs!.setBool('isFirstTime', false);
      navigateToOnboarding();
    } else {
      navigateToLogin();
    }
  }

  navigateToOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    Future.delayed(const Duration(seconds: 2), () {
      // if (isFirstTime) {
      //   Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) {
      //     return const OnBoardingScreen();
      //   }), (route) => false);
      // } else {
      //   Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) {
      //     return const SignupScreen();
      //   }), (route) => false);
      // }

      PageNavigator(ctx: context).nextPage(page: const OnBoardingScreen());
      // PageNavigator(ctx: context).nextPage(page: const OnBoardingScreen());
    });
  }

  navigateToLogin() {
    // Replace this with your logic to navigate to the login screen
    // Example: Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topRight,
      //     end: Alignment.bottomLeft,
      //     colors: [
      //       Colors.blue,
      //       Colors.red,
      //     ],
      //   ),
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppImages.logo,
                  ),
                ),
                const SizedBox(height: 20), // Adjust the height as needed
              ],
            ),
            // const Positioned(
            //   bottom: 200,
            //   child: CircularProgressIndicator(),
            // ),
            // Positioned(
            //     bottom: -20,
            //     child: SvgPicture.asset(
            //       AppImages.curveLine,
            //     )),
            // Positioned(
            //     bottom: -60,
            //     child: SvgPicture.asset(
            //       AppImages.curveLine,
            //     ))
          ],
        ),
      ),
    );
  }
}

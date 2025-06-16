import 'package:coaching_academy/MVVM/views/global/auth/forgot_password/forgot_password_step1.dart';
import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/global/auth/login/user_role.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modules/coach/dashboard/coach_dashboard.dart';
import '../../../modules/sporty/dashboard/sporty_dashboard.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [SvgPicture.asset(AppImages.bottomMiddleRoundRing)],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const CustomText(
                text: "Welcome to TREENER",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: const GreyCustomText(
                text:
                    "Enter the email and password you registered with to access your account.",
                textAlign: TextAlign.left,
              ),
            ),
            filterHeading("Email or Phone Number"),
            10.verticalSpace,
            CustomTextField(
              iconPath: AppImages.emailIcon,
              controller: emailController,
              hintText: "Enter your email address",
            ),
            20.verticalSpace,
            filterHeading("Password"),
            10.verticalSpace,
            GestureDetector(
              child: CustomTextField(
                iconPath: AppImages.passwordIcon,
                controller: passwordController,
                hintText: "Enter your password",
                isObscure: true,
                maxLines: 1,
              ),
            ),
            GestureDetector(
              onTap: () {
                PageNavigator(ctx: context).nextPage(
                  page: const ForgotPasswordStep1(),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "Forgot Password?",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            50.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  buttonText: "Login",
                  onPressed: () async {
                    await loginUser(); // attends que la méthode se termine

                  }
                ), 
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }


  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<bool> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return false;
    }

    final url = Uri.parse('http://localhost:8000/api/login');

    try 
    {
      print("salut");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //print('Connexion réussie : $data');
        //print("Token on login page $data['token']");
        await saveToken(data['token']);
        //print("token saved");

        showWhitePopup(
          context: context,
          title: "Congratulations",
          description: "Welcome Aboard! Your login was successful.",
          buttonText: "Let's go!",
          onPress: () async {
            //PageNavigator(ctx: context).nextPage(page: const UserRoleScreen());
            await fetchAndRedirectUser();

          },
        );
        return true;
      } else {
        //print('Erreur de connexion : ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email ou mot de passe incorrect')),
        );
        return false;
      }
    } catch (e) {
      print('Exception : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur s\'est produite')),
      );
      return false;
    }
  }

  Future<void> fetchAndRedirectUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token introuvable.')),
      );
      return;
    }

    final url = Uri.parse('http://localhost:8000/api/user');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(data));

        final role = data['role'];

        if (role == 'coach') {
          PageNavigator(ctx: context).nextPage(page: CoachDashboard());
        } else if (role == 'sporty') {
          PageNavigator(ctx: context).nextPage(page: SportyDashboard());
        } else {
          PageNavigator(ctx: context).nextPage(page: const UserRoleScreen());
        }
      } else {
        print('Erreur lors de la récupération de l’utilisateur : ${response.body}');
        PageNavigator(ctx: context).nextPage(page: const UserRoleScreen());
      }
    } catch (e) {
      print('Erreur lors de la redirection : $e');
      PageNavigator(ctx: context).nextPage(page: const UserRoleScreen());
    }
  }



}

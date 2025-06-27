import 'dart:convert';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/subscription/subscription_step2.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/widgets/toast/custom_toast.dart';

class SubscriptionStep1 extends StatelessWidget {
  const SubscriptionStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Fees Plan",
          centerTitle: false,
          onPress: () {
            Navigator.pop(context);
          }),
      body: const SubscriptionBody(),
    );
  }
}

class SubscriptionBody extends StatefulWidget {
  const SubscriptionBody({super.key});

  @override
  _SubscriptionBodyState createState() => _SubscriptionBodyState();
}

class _SubscriptionBodyState extends State<SubscriptionBody> {
  int _selectedPlan = 2; // Default selected yearly plan
  int _selectedPaymentMethod = 1; // Default selected Credit Card


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreyCustomText(
            text: "Get started with easy payments",
            style: GoogleFonts.urbanist(
                color: const Color(0xff797979),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          10.verticalSpace,
          CustomText(
            text: "Select",
            style: GoogleFonts.urbanist(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          10.verticalSpace,
          GreyCustomText(
            text: "Select what suits you best",
            style: GoogleFonts.urbanist(
                color: const Color(0xff797979),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          _buildPlanOption(
            1,
            "Basic - 19.99€/mois",
            features: [
              "Accès à l'agenda client",
              "Prise de rendez-vous en ligne",
              "Facturation, devis et paiements",
              "Notifications par mail",
              "Messagerie interne"
            ],
          ),
          30.verticalSpace,
          _buildPlanOption(
            2,
            "Pro - 39.99€/mois",
            isBestValue: true,
            features: [
              "Toutes les fonctionnalités du Basic",
              "Créateur de programmes",
              "Coaching en visio",
              "Publication réseaux sociaux",
              "Suivi des progrès",
              "Personal branding"
            ],
          ),

          const SizedBox(height: 30),
          CustomText(
            text: "Select Payment Method",
            style: GoogleFonts.urbanist(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          GreyCustomText(
            text: "Select your preferred one",
            style: GoogleFonts.urbanist(
                color: const Color(0xff797979),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          _buildPaymentMethod(
              1, "Credit Card", AppImages.mastercardLogo, Colors.red),
          10.verticalSpace,
          _buildPaymentMethod(2, "PayPal", AppImages.paypalLogo, Colors.blue),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              final token = await getToken(); // ta fonction pour récupérer le token d’auth
              final email = await getEmail(); // récupère dynamiquement l’email de l’utilisateur

              if (token == null || email == null) {
                showToast(context: context, message: "Utilisateur non authentifié !");
                return;
              }

              if (_selectedPaymentMethod == 1) {
                // Paiement uniquement si carte de crédit sélectionnée
                final selectedPlanId = _selectedPlan == 1
                    ? 'price_id_basic' // ← remplace par l'ID Stripe réel
                    : 'price_id_pro';  // ← remplace par l'ID Stripe réel
                print("price_id: $selectedPlanId");
                await subscribeToPlan(selectedPlanId, token, email);
              } else {
                showToast(
                  context: context,
                  message: "Le paiement par PayPal n’est pas encore disponible.",
                );
              }
            },

            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              foregroundColor: Colors.black, backgroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50), // Full-width button
            ),
            child: CustomText(
              text: "Pay & Continue",
              style: GoogleFonts.urbanist(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final user_data =  prefs.getString('user_data'); // doit être défini à la connexion
    print('user data: $user_data');
    if (user_data == null || user_data.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(user_data);
      return decoded['email'];
    } catch (e) {
      print("Erreur décodage email: $e");
      return null;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }



  Widget _buildPlanOption(int value, String title,
      {bool isBestValue = false, List<String>? features}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _selectedPlan == value ? Colors.green : AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: CustomText(
                  text: title,
                  style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16),
                ),
                trailing: _selectedPlan == value
                    ? const Icon(FontAwesomeIcons.circleCheck, color: Colors.white)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedPlan = value;
                  });
                },
              ),
              if (features != null)
                ...features.map((f) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Flexible(
                        child: CustomText(
                          text: f,
                          style: GoogleFonts.urbanist(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
            ],
          ),
        ),
        if (isBestValue)
          Positioned(
            top: -12,
            right: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.primaryGreen, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: CustomText(
                text: "Best Value",
                color: AppColors.primaryGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }


  Widget _buildPaymentMethod(
      int value, String title, String iconPath, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: SvgPicture.asset(iconPath),
        title: CustomText(
          text: title,
          style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16),
        ),
        trailing: Radio(
          value: value,
          groupValue: _selectedPaymentMethod,
          onChanged: (int? newValue) {
            setState(() {
              _selectedPaymentMethod = newValue!;
            });
          },
          activeColor: AppColors.primaryGreen,
        ),
      ),
    );
  }



  Future<void> subscribeToPlan(String plan, String token, String email) async {
    try {
      // Création du PaymentMethod
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              email: email,
            ),
          ),
        ),
      );

      final response = await http.post(
        Uri.parse('http://localhost:8000/api/subscribe'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'plan': plan, // 'basic' ou 'pro'
          'payment_method': paymentMethod.id,
        }),
      );

      if (response.statusCode == 200) {
        print("Souscription réussie !");
        PageNavigator(ctx: context).nextPage(page: const SubscriptionStep2());
      } else {
        print("Erreur backend : ${response.body}");
      }
    } catch (e) {
      print("Erreur Stripe : $e");
    }
  }


}

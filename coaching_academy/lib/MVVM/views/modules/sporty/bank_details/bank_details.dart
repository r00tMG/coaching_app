import 'dart:convert';

import 'package:coaching_academy/MVVM/models/CoachServiceModel.dart';
import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_payment/stripe_payment.dart' hide PaymentMethod;
import 'package:url_launcher/url_launcher.dart';

class BankDetailsPage extends StatefulWidget {
  final VoidCallback onSavePress;
  final CoachServiceModel coachServices;

  const BankDetailsPage({
    super.key,
    required this.onSavePress,
    required this.coachServices,
  });

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  @override
  void dispose() {
    bankNameController.dispose();
    accountNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Bank Details",
        onPress: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildTextField('Bank Name', controller: bankNameController),
            const SizedBox(height: 16),
            buildTextField('Account Number', controller: accountNumberController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: buildTextField('Owner first name', controller: firstNameController)),
                const SizedBox(width: 16),
                Expanded(child: buildTextField('Last name', controller: lastNameController)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: buildTextField('City', controller: cityController)),
                const SizedBox(width: 16),
                Expanded(child: buildTextField('Postal Code', controller: postalCodeController)),
              ],
            ),
            const Spacer(),
            buildSaveButton(
              context: context,
              onPress: () async {
                try {
                  await saveBankDetailsToAPI();
                  await startStripeCheckout(double.parse(widget.coachServices.price), widget.coachServices.name);
                  widget.onSavePress(); // si redirection après paiement
                } catch (e) {
                  print("Erreur Stripe ou sauvegarde: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hint, {required TextEditingController controller}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Future<void> saveBankDetailsToAPI() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.post(
      Uri.parse('http://localhost:8000/api/user/bank-details'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'bank_name': bankNameController.text,
        'account_number': accountNumberController.text,
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'city': cityController.text,
        'postal_code': postalCodeController.text,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la sauvegarde des infos bancaires');
    }
  }

  Future<void> startStripeCheckout(double amount, String serviceName) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/create-checkout-session'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'price': amount,
        'service_name': serviceName,
      }),
    );

    if (response.statusCode == 200) {
      final url = jsonDecode(response.body)['url'];
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Impossible de lancer le paiement.');
      }
    } else {
      throw Exception('Erreur lors de la création de la session Stripe');
    }
  }
}


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import '../../../../../utils/helper/global_helper.dart';
import '../../../global/auth/helper/global_helper.dart';

class EditServiceScreen extends StatefulWidget {
  final int serviceId;

  const EditServiceScreen({super.key, required this.serviceId});

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchServiceData();
  }

  Future<void> fetchServiceData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    try {
      final response = await http.get(
        Uri.parse('http://0.0.0.0:8000/api/coach/services/${widget.serviceId}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final service = jsonDecode(response.body)['service'];
        setState(() {
          nameController.text = service['name'];
          durationController.text = service['duration'].toString();
          priceController.text = service['price'].toString();
        });
      } else {
        GlobalHelper.showErrorSnackbar(context, "Erreur de récupération du service.");
      }
    } catch (e) {
      GlobalHelper.showErrorSnackbar(context, "Erreur : $e");
    }
  }

  Future<void> updateService() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    setState(() {
      isLoading = true;
    });

    final response = await http.put(
      Uri.parse('http://0.0.0.0:8000/api/coach/services/${widget.serviceId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': nameController.text,
        'duration': int.tryParse(durationController.text),
        'price': double.tryParse(priceController.text),
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      GlobalHelper.showSuccessSnackbar(context, "Service modifié avec succès !");
      Navigator.pop(context, true); // retourne à l'écran précédent
    } else {
      GlobalHelper.showErrorSnackbar(context, "Erreur lors de la mise à jour.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Edit Service",
        onPress: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomText(text: "Name", fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            5.verticalSpace,
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            20.verticalSpace,
            CustomText(text: "Duration (min)", fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            5.verticalSpace,
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            20.verticalSpace,
            CustomText(text: "Price", fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            5.verticalSpace,
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            30.verticalSpace,
            isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
              buttonText: "Update",
              onPressed: updateService,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

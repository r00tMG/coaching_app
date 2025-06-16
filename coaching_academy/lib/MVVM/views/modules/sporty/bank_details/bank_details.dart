import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:flutter/material.dart';

class BankDetailsPage extends StatelessWidget {
  final VoidCallback onSavePress;
  const BankDetailsPage({super.key, required this.onSavePress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Bank Details",
          onPress: () {
            Navigator.pop(context);
          }),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildTextField('Bank Name'),
            const SizedBox(height: 16),
            buildTextField('Account Number'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: buildTextField('Owner first name')),
                const SizedBox(width: 16),
                Expanded(child: buildTextField('Last name')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: buildTextField('City')),
                const SizedBox(width: 16),
                Expanded(child: buildTextField('Postal Code')),
              ],
            ),
            const Spacer(),
            buildSaveButton(context: context, onPress: onSavePress),
          ],
        ),
      ),
    );
  }
}

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/onboarding/show_off_workspace.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WorkingHoursScreen extends StatefulWidget {
  const WorkingHoursScreen({super.key});

  @override
  _WorkingHoursScreenState createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends State<WorkingHoursScreen> {
  int startHour = 14; // Initial start hour
  int endHour = 17; // Initial end hour

  // New variable to keep track of selected training option
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Working Hours",
          onPress: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: "Your Work Hours",
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                isPoppins: true,
              ),
              const SizedBox(height: 10),
              const GreyCustomText(
                text: "Set your hours here.",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                isPoppins: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTimePicker(true), // Start time picker
                  _buildTimePicker(false), // End time picker
                ],
              ),
              const SizedBox(height: 30),
              const CustomText(
                text: "Training Options",
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                isPoppins: true,
              ),
              const SizedBox(height: 10),
              _buildOptionButton("Gym"),
              _buildOptionButton("At Home"),
              _buildOptionButton("Any Where"),
              _buildOptionButton("Outside"),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // onPressed: () {
                  //   PageNavigator(ctx: context)
                  //       .nextPage(page: const ShowOffWorkspaceScreen());
                  // },
                  onPressed: () {
                    if (selectedOption != null) {
                      _saveWorkingHours(context: context);

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Veuillez sélectionner une option.')),
                      );
                    }
                  },

                  child: const CustomText(
                    text: "Continue",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    isPoppins: true,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(bool isStart) {
    final selectedHour = isStart ? startHour : endHour;
    return SizedBox(
      width: 100,
      height: 120,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
          initialItem: selectedHour - 12,
        ),
        itemExtent: 40.0,
        onSelectedItemChanged: (int index) {
          setState(() {
            if (isStart) {
              startHour = index + 12; // Update start hour
            } else {
              endHour = index + 12; // Update end hour
            }
          });
        },
        children: List<Widget>.generate(7, (int index) {
          final hour = index + 12;
          final isSelected = hour == selectedHour;
          return Center(
            child: CustomText(
              text: '${hour.toString().padLeft(2, '0')}:00',
              style: TextStyle(
                color: isSelected
                    ? AppColors.primaryGreen
                    : Colors.grey, // Green for selected, grey for others
                fontSize: 24,
              ),
            ),
          );
        }),
      ),
    );
  }

  // Modify _buildOptionButton to add selection feature
  Widget _buildOptionButton(String label) {
    final isSelected =
        selectedOption == label; // Check if this option is selected
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = label; // Update the selected option when tapped
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : Colors.transparent, // Green border if selected
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              isPoppins: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveWorkingHours({required BuildContext context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      print("token location page $token");
      final response = await http.post(
        Uri.parse('http://0.0.0.0:8000/api/coach/working-hours'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'start_hour': startHour,
          'end_hour': endHour,
          'training_option': selectedOption,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Aller à l'écran suivant
        PageNavigator(ctx: context)
            .nextPage(page: const ShowOffWorkspaceScreen());
      } else {
        // Afficher une erreur si besoin
        print("Erreur lors de l'envoi: ${response.body}");
      }
    } catch (e) {
      print("Erreur : $e");
    }
  }

}

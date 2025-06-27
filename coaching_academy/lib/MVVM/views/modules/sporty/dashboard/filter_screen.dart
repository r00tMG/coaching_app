import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/filter_result.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/dropdown/custom_dropdown.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController locationController = TextEditingController();
  String selectedGender = 'Male';
  final List<String> cities = [
    "Select here",
    'Karachi',
    'Lahore',
    'Islamabad',
    'Rawalpindi',
    'Peshawar',
    'Quetta',
    'Multan',
    'Faisalabad',
    'Sialkot',
    'Hyderabad',
  ];

  String? selectedCity = "Select here";

  final List<String> regions = [
    "Select here",
    'Punjab',
    'Sindh',
    'Khyber Pakhtunkhwa',
    'Balochistan',
    'Gilgit-Baltistan',
    'Azad Kashmir',
    'Islamabad Capital Territory',
  ];

  final List<String> coachingTypes = [
    "Select here",
    'Fitness Coaching',
    'Career Coaching',
    'Language Coaching',
    'Life Coaching',
    'Business Coaching',
    'Mindset Coaching',
    'Health & Nutrition Coaching',
    'Relationship Coaching',
    'Leadership Coaching',
    'Financial Coaching',
  ];

  // Initial selected value
  String? selectedCoachingType = "Select here";

  String? selectedRegion = "Select here";
  final List<String> languages = [
    "Select here",
    'English',
    'Urdu',
    'French',
    'Spanish',
    'German',
    'Chinese',
    'Arabic',
    'Japanese',
    'Russian',
    'Hindi',
  ];

  // Initial selected language
  String? selectedLanguage = "Select here";
  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Filter",
        onPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filterHeading("Location"),
            10.verticalSpace,
            CustomTextField(
                controller: locationController, hintText: "Enter Address"),
            10.verticalSpace,
            filterHeading("Choose City"),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomDropdown(
                  backgroundColor: Colors.white,
                  items: cities,
                  value: selectedCity,
                  onChanged: (v) {}),
            ),
            10.verticalSpace,
            filterHeading("Region"),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomDropdown(
                  backgroundColor: Colors.white,
                  items: regions,
                  value: selectedRegion,
                  onChanged: (v) {}),
            ),
            10.verticalSpace,
            filterHeading("Online Coaching"),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomDropdown(
                  backgroundColor: Colors.white,
                  items: coachingTypes,
                  value: selectedCoachingType,
                  onChanged: (v) {}),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                filterHeading('Availability'),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Switch(
                    trackColor:
                        WidgetStateProperty.all(const Color(0xffaeaeae)),
                    thumbColor: WidgetStateProperty.all(
                        isAvailable ? AppColors.primaryGreen : Colors.black),
                    value: isAvailable,
                    onChanged: (bool newValue) {
                      setState(() {
                        isAvailable = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            filterHeading('Gender Preference'),
            Container(
              padding: const EdgeInsets.only(right: 10, left: 8),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRadioButton('Male', selectedGender),
                  40.horizontalSpace,
                  _buildRadioButton('Female', selectedGender),
                ],
              ),
            ),
            10.verticalSpace,
            filterHeading('Select Language'),
            10.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomDropdown(
                  backgroundColor: Colors.white,
                  items: languages,
                  value: selectedLanguage,
                  onChanged: (v) {}),
            ),
            40.verticalSpace,
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                    buttonText: "Apply Filter",
                    onPressed: () {

                      PageNavigator(ctx: context)
                          .nextPage(page: const FilterResultScreen(filteredServices: []));
                    }))
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(String label, String groupValue) {
    return Row(
      children: [
        Radio<String>(
          activeColor: Colors.green,
          value: label,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
        ),
        CustomText(
          text: label,
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

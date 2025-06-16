import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  // Define the colors
  static Color backgroundGrey = const Color(0xff333333);
  static Color primaryGreen = const Color(0xff5CFF58);

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Future getImageFromGallery() async {
    print("########### INSIDE FUNCTION ##########");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Edit Profile",
          onPress: () {
            Navigator.pop(context);
          }),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            20.verticalSpace,
            GestureDetector(
              onTap: getImageFromGallery,
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppImages.profilePictureRectangle,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // Handle picture change
                    },
                    child: const CustomText(
                      text: 'Add Picture',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Name TextField
            heading("Name"),
            10.verticalSpace,
            _buildTextField('Name', 'Emma'),
            const SizedBox(height: 16),
            heading("Email"),
            10.verticalSpace,
            // Email TextField
            _buildTextField('Email', 'emma4676@gmail.com',
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            heading("My Location"),
            10.verticalSpace,
            // Location TextField
            _buildTextField('My Location', 'france, crtri etc'),
            const SizedBox(height: 16),
            heading("Password"),
            10.verticalSpace,
            // Password TextField
            _buildTextField('Password', '************', obscureText: true),
            const SizedBox(height: 32),
            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: CustomText(
                  text: 'Save',
                  style: TextStyle(
                    color: EditProfileScreen.backgroundGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row heading(String text) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  // Helper method to build TextFields
  Widget _buildTextField(String label, String placeholder,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: Colors.white),
      decoration: InputDecoration(
        fillColor: AppColors.backgroundGrey,
        filled: true,
        // labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.white),
        hintText: placeholder,
        hintStyle: GoogleFonts.poppins(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        // suffixIcon: obscureText
        //     ? const Icon(Icons.visibility, color: Colors.white70)
        //     : null,
      ),
    );
  }
}

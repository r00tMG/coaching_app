import 'dart:convert';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:http_parser/http_parser.dart';

class CoachEditProfileScreen extends StatefulWidget {
  // Define the colors
  static Color backgroundGrey = const Color(0xff333333);
  static Color primaryGreen = const Color(0xff5CFF58);

  const CoachEditProfileScreen({super.key});

  @override
  State<CoachEditProfileScreen> createState() => _CoachEditProfileScreenState();
}

class _CoachEditProfileScreenState extends State<CoachEditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String userName = '';
  String email = '';
  String address = '';
  String? userPhotoUrl;
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  XFile? _image;
  Uint8List? _webImageBytes;

  Future<void> getImageFromGallery() async {
    if (kIsWeb) {
      final html.FileUploadInputElement input = html.FileUploadInputElement()..accept = 'image/*';
      input.click();
      input.onChange.listen((e) {
        final file = input.files!.first;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((e) {
          setState(() {
            _webImageBytes = reader.result as Uint8List;
            userPhotoUrl = html.Url.createObjectUrlFromBlob(file); // affichage
          });
        });
      });
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }
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
                  userPhotoUrl != null && userPhotoUrl!.isNotEmpty
                      ? Image.network(
                    userPhotoUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : SvgPicture.asset(
                    AppImages.coachRectangleImage,
                    width: 100,
                    height: 100,
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
            _buildTextField('Name', _nameController),
            const SizedBox(height: 16),
            heading("Email"),
            10.verticalSpace,
            // Email TextField
            _buildTextField('Email', _emailController,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            heading("My Location"),
            10.verticalSpace,
            // Location TextField
            _buildTextField('My Location', _addressController),
            const SizedBox(height: 16),
            heading("Password"),
            10.verticalSpace,
            // Password TextField
            _buildTextField('Password', _passwordController, obscureText: true),
            const SizedBox(height: 32),
            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.pop(context);
                  updateProfile();
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
                    color: CoachEditProfileScreen.backgroundGrey,
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
  /*Widget _buildTextField(String label, String placeholder,
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
  }*/
  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false,
        TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: Colors.white),
      decoration: InputDecoration(
        fillColor: AppColors.backgroundGrey,
        filled: true,
        hintText: label,
        hintStyle: GoogleFonts.poppins(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('http://0.0.0.0:8000/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userName = data['name'];
        userPhotoUrl = data['profile_picture'];
        address = data['address'];
        email = data['email'];
        //print('photo profile: $userPhotoUrl');
        _nameController.text = userName;
        _emailController.text = email;
        _addressController.text = address;
      });
    } else {
      print("Erreur: ${response.statusCode}");
    }
  }

  /*Future<void> updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    var request = http.MultipartRequest(
      'PUT', // ou PUT si supporté par ton backend
      Uri.parse('http://0.0.0.0:8000/api/coach/update'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = _nameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['address'] = _addressController.text;
    request.fields['password'] = _passwordController.text;

    if (_image != null) {
      if (kIsWeb) {
        final bytes = await _image!.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          'profile_picture',
          bytes,
          filename: _image!.name,
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          _image!.path,
        ));
      }
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Profile updated successfully");
      Navigator.pop(context);
    } else {
      print("Failed to update profile");
    }
  }*/

  Future<void> updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:8000/api/coach/update'), // ou ton IP locale
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = _nameController.text;
    request.fields['email'] = _emailController.text;
    request.fields['address'] = _addressController.text;
    request.fields['password'] = _passwordController.text;

    if (kIsWeb && _webImageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'profile_picture',
        _webImageBytes!,
        filename: 'profile.png',
        contentType: MediaType('image', 'png'),
      ));
    } else if (!kIsWeb && _image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profile_picture',
        _image!.path,
      ));
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Profile updated successfully");
      Navigator.pop(context);
    } else {
      final responseBody = await response.stream.bytesToString();
      print("Failed to update profile: $responseBody");
    }
  }




}

import 'dart:convert';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ContactUs extends StatefulWidget {
  // Define the colors
  static Color backgroundGrey = const Color(0xff333333);
  static Color primaryGreen = const Color(0xff5CFF58);

  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  // Validate the inputs (check if all fields are filled)
  bool _validateInputs() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields.')),
      );
      return false;
    }
    return true;
  }

  String address = '';
  String email = '';
  int id = 0;
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Contact Us",
          onPress: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Name TextField
                heading("First Name"),
                10.verticalSpace,
                _buildTextField(controller: firstNameController, ''),
                heading("Last Name"),
                10.verticalSpace,
                // Location TextField
                _buildTextField(controller: lastNameController, ''),
                const SizedBox(height: 16),
                heading("Email"),
                10.verticalSpace,
                // Email TextField
                _buildTextField(
                    controller: emailController,
                    '',
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),

                heading("Message"),
                10.verticalSpace,
                // Password TextField
                _buildTextField(controller: messageController, '', maxLines: 5),
                20.verticalSpace,
                Row(
                  children: [
                    CustomText(
                      text: "Contact Information",
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
                20.verticalSpace,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.locationFilledIcon,
                      color: const Color(0xff158FFF),
                    ),
                    10.horizontalSpace,
                    GreyCustomText(
                      text: address != null ? address : "Lorem ipsum dolor sit amet consectetur ",
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffa1a1a1)),
                    ),
                  ],
                ),
                20.verticalSpace,
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.phone,
                      color: Color(0xff04BD00),
                    ),
                    10.horizontalSpace,
                    GreyCustomText(
                      text: "+45 71 98 78 02 ",
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffa1a1a1)),
                    ),
                  ],
                ),
                20.verticalSpace,
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Color(0xffF30909),
                    ),
                    10.horizontalSpace,
                    GreyCustomText(
                      text: email != null ? email : "danilo@uscreen.tv",
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffa1a1a1)),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      sendMessage();
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
                        color: ContactUs.backgroundGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
  Widget _buildTextField(String placeholder,
      {bool obscureText = false,
      required TextEditingController controller,
      TextInputType keyboardType = TextInputType.text,
      int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      //style: GoogleFonts.poppins(color: Colors.white),
      style: GoogleFonts.poppins(color: Colors.black),

      decoration: InputDecoration(
        fillColor: AppColors.white,
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
        //userName = data['name'];
        //userPhotoUrl = data['profile_picture'];
        id = data['id'];
        email = data['email'];
        address = data['address'];
        //print('photo profile: $userPhotoUrl');
        //_nameController.text = userName;
        _emailController.text = email;
        _addressController.text = address;
      });
    } else {
      print("Erreur: ${response.statusCode}");
    }
  }

   Future<void> sendMessage() async {
     final prefs = await SharedPreferences.getInstance();
     final token = prefs.getString('auth_token');
    if (_validateInputs()) {
      // Créez un objet JSON avec les données
      final Map<String, dynamic> requestBody = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'message': messageController.text,
        'sender_id': id,
        //'receiver_id':
      };

      final String apiUrl = 'http://0.0.0.0:8000/api/contact_us';

      try {
        // Envoi de la requête POST à l'API
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':'Bearer $token'
          },
          body: json.encode(requestBody), // Convertir l'objet en JSON
        );

        // Vérifiez si la requête a réussi
        if (response.statusCode == 200) {
          // Si la requête a réussi, montrez un message de confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Message sent successfully!')),
          );

          // Optionnellement, videz les champs de texte après envoi
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          messageController.clear();
        } else {
          // Si la requête échoue, affichez un message d'erreur
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send message. Please try again.')),
          );
        }
      } catch (e) {
        // Si une erreur se produit (ex : problème de connexion)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again later.')),
        );
      }
    }
  }

}

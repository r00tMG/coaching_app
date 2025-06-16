import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AskNowScreen extends StatefulWidget {
  const AskNowScreen({super.key});

  @override
  State<AskNowScreen> createState() => _AskNowScreenState();
}

class _AskNowScreenState extends State<AskNowScreen> {
  String _selectedVisibility = "Public"; // Default value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
          ),
          child: CustomText(
            text: "Ask Now",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText(
          text: "Create a post",
          style: GoogleFonts.abel(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppImages.addPostsProfilePic),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Cameron Nicholas",
                        style: GoogleFonts.abel(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        height: 20,
                        padding: EdgeInsets.zero,
                        child: DropdownButton<String>(
                          value: _selectedVisibility,
                          dropdownColor: Colors.grey[900],
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.grey),
                          underline: const SizedBox(), // Removes the underline
                          items: ["Public", "Private"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: CustomText(
                                text: value,
                                style: GoogleFonts.abel(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedVisibility = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                style: GoogleFonts.abel(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: "Add topic name",
                  hintStyle: GoogleFonts.abel(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 8,
                style: GoogleFonts.abel(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: "What do you want to talk about?",
                  hintStyle: GoogleFonts.abel(
                      color: const Color(0xff7a7a7a),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

void showChatBottomSheet(
    BuildContext context, Function showCamera, Function showGallery) {
  showModalBottomSheet(
    backgroundColor: Colors.black,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: SvgPicture.asset(AppImages.cameraIcon),
                title: CustomText(
                    text: 'Camera',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white)),
                onTap: () {
                  // Handle Camera action
                  showCamera();
                },
              ),
              const Divider(),
              ListTile(
                leading: SvgPicture.asset(AppImages.photoIcon),
                title: CustomText(
                    text: 'Photo & Video Library',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white)),
                onTap: () {
                  // Handle Photo & Video Library
                  showGallery();
                },
              ),
              const Divider(),
              ListTile(
                leading: SvgPicture.asset(AppImages.documentIcon),
                title: CustomText(
                    text: 'Document',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white)),
                onTap: () {
                  // Handle Document action
                },
              ),
              const Divider(),
              ListTile(
                leading: SvgPicture.asset(AppImages.locationIcon),
                title: CustomText(
                    text: 'Location',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white)),
                onTap: () {
                  // Handle Location action
                },
              ),
              const Divider(),
              ListTile(
                leading: SvgPicture.asset(AppImages.contactIcon),
                title: CustomText(
                    text: 'Contact',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white)),
                onTap: () {
                  // Handle Contact action
                },
              ),
              const Divider(),
              // const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 60),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: CustomText(
                  text: 'Cancel',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}

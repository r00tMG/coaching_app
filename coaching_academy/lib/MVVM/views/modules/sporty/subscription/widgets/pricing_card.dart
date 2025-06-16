import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingCard extends StatelessWidget {
  const PricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // The main card
        Container(
          width: 190,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryGreen,
              width: 4,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 22), // Space for the POPULAR badge
              CustomText(
                text: "12",
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              CustomText(
                text: "months",
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              // const SizedBox(height: 1),
              CustomText(
                text: "\$45.99",
                style: GoogleFonts.urbanist(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              CustomText(
                text: "\$3.83/mo",
                style: GoogleFonts.urbanist(
                    fontSize: 17,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),

        // The 'POPULAR' badge on top, overlapping the card
        Positioned(
          top: -10, // Moves the badge upwards to overlap the card
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen, // Light green color for the badge
              borderRadius: BorderRadius.circular(30),
            ),
            child: const CustomText(
              text: "POPULAR",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

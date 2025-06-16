import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerOptionWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color? textColor;
  final VoidCallback onPress;

  const DrawerOptionWidget({
    super.key,
    required this.title,
    required this.imagePath,
    this.textColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            SvgPicture.asset(imagePath),
            10.horizontalSpace,
            CustomText(
              text: title,
              style: GoogleFonts.montserrat(
                color: textColor ?? Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

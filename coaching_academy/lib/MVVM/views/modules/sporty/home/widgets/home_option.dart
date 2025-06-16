import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeOption extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final String iconPath;
  const HomeOption({
    super.key,
    required this.title,
    required this.onPress,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      elevation: 0,
      shadowColor: Colors.transparent,
      pressElevation: 0,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(30)),
      avatar: SvgPicture.asset(iconPath),
      label: CustomText(
        text: title,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      labelStyle:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
      backgroundColor: AppColors.backgroundGrey,
      onPressed: onPress,
    );
  }
}

class HomeOption2 extends StatelessWidget {
  final VoidCallback onPress;
  const HomeOption2({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.backgroundGrey,
        ),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          children: [
            SvgPicture.asset(AppImages.fitnessIcon),
            9.horizontalSpace,
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Outside",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: "See Details",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

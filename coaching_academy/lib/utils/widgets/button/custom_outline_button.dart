import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String buttonText;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final dynamic borderRadius;
  final double? fontSize;
  final IconData? icon;
  final String? image;
  final double? imageSize;
  final Color? iconColor;
  final FontWeight? fontWeight;
  final double? buttonWidth;
  final double? buttonHeight;
  const CustomOutlineButton({
    super.key,
    required this.buttonText,
    this.backgroundColor,
    required this.onPressed,
    this.borderRadius,
    this.fontWeight,
    this.fontSize,
    this.icon,
    this.iconColor,
    this.image,
    this.textColor,
    this.imageSize,
    this.buttonWidth,
    this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(buttonWidth ?? double.infinity, buttonHeight ?? 55),
        // side: BorderSide.none,
        side: const BorderSide(
          color: Color(0xffCBD5E1),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: buttonText,
                fontSize: fontSize ?? 14.0,
                color: textColor ?? AppColors.white,
                fontWeight: fontWeight,
              ),
            ],
          )
        ],
      ),
    );
  }
}

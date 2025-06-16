import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
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
  final double? buttonHeight;
  final double? buttonWidth;
  final Color? borderSide;
  const CustomButton(
      {super.key,
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
      this.borderSide,
      this.buttonHeight,
      this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(buttonWidth ?? double.infinity, buttonHeight ?? 55),
          backgroundColor: backgroundColor ?? Colors.white,
          side: BorderSide(color: borderSide ?? AppColors.containerBorderclr),
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
                  color: textColor ?? AppColors.black,
                  fontWeight: fontWeight,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final Widget title;
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
  const CustomButton2({
    super.key,
    required this.title,
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            backgroundColor: backgroundColor ?? Colors.white,
            side: BorderSide(color: AppColors.containerBorderclr),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: title,
        ));
  }
}

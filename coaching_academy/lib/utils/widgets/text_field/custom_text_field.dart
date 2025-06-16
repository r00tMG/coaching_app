import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final bool? clickable;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final String iconPath;
  final Color? fillColor;
  final Color? iconColor;
  final double? letterSpacing;
  final double? textFontSize;
  final Color? textColor;
  final Color? hintTextColor;
  final FontWeight? fontWeight;
  final String? suffixText;
  final bool isIconColor;
  final int? maxLines;
  final double? borderRadius;
  final FocusNode? focusNode;
  final Widget? label;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final InputBorder? borderType;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.letterSpacing,
      this.suffixIcon,
      this.prefixIcon,
      this.fillColor,
      this.isObscure = false,
      this.clickable,
      this.iconPath = "",
      this.contentPadding,
      this.readOnly,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.maxLength,
      this.textFontSize,
      this.textColor,
      this.isIconColor = true,
      this.fontWeight,
      this.suffixText,
      this.maxLines,
      this.borderColor,
      this.hintTextColor,
      this.iconColor,
      this.borderRadius,
      this.focusNode,
      this.label,
      this.labelStyle,
      this.hintStyle,
      this.style,
      this.floatingLabelBehavior,
      this.borderType,
      });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        focusNode: widget.focusNode,
        // maxLength: 10,
        style: widget.style ??
            GoogleFonts.poppins(
              letterSpacing: widget.letterSpacing,
              fontSize: widget.textFontSize,
              color: widget.textColor,
              fontWeight: widget.fontWeight,
            ),

        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly ?? false,
        controller: widget.controller,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        obscureText: widget.isObscure,
        // style: TextStyle(
        //   color: widget.clickable == false ? Colors.black : Colors.black,
        // ),p

        decoration: InputDecoration(
          floatingLabelBehavior: widget.floatingLabelBehavior,
          labelStyle: widget.labelStyle,
          label: widget.label,
          fillColor: widget.fillColor ?? Colors.white,
          filled: true,
          prefixIcon: widget.iconPath.isNotEmpty
              ? SvgPicture.asset(
                  widget.iconPath,
                  color: widget.isIconColor
                      ? widget.iconColor ?? const Color(0xff858585)
                      : null,
                  fit: BoxFit.scaleDown,
                )
              : null,
          // prefix: SvgPicture.asset(
          //   widget.iconPath,
          //   color: const Color(0xff858585),
          //   fit: BoxFit.scaleDown,
          // ),
          counterText: '',
          suffixText: widget.suffixText,
          suffixIcon: widget.suffixIcon,

          focusedBorder: widget.borderType ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.lightGrey,
                ), // Change the border color here
              ),
          enabledBorder: widget.borderType ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),

                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.lightGrey,
                ), // Change the border color here
              ),
          disabledBorder: widget.borderType ??
              OutlineInputBorder(
                // Define disabled border
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),

                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.lightGrey,
                ), // Same color as other borders
              ),

          contentPadding: widget.contentPadding,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              GoogleFonts.inter(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: widget.hintTextColor,
              ),
        ),

        onChanged: widget.onChanged,
      ),
    );
  }
}

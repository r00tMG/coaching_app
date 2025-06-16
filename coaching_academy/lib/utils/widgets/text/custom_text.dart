// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatefulWidget {
  final bool isPoppins;
  final text,
      fontWeight,
      color,
      overflow,
      textAlign,
      maxLines,
      letterSpacing,
      decoration,
      shadows,
      decorationColor,
      softWrap;
  final double? fontSize;
  final double? lineHeight;
  final TextStyle? style;
  const CustomText(
      {this.text,
      this.letterSpacing,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.overflow,
      this.decoration,
      this.textAlign,
      this.maxLines,
      this.shadows,
      this.decorationColor,
      this.softWrap,
      this.lineHeight,
      key,
      this.isPoppins = false,
      this.style})
      : super(key: key);

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return
        // text: widget.text,
        Text(
      widget.text,
      style: widget.style ??
          (widget.isPoppins
              ? GoogleFonts.poppins(
                  // fontFamily: "Poppins",
                  letterSpacing: widget.letterSpacing,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight ?? FontWeight.normal,
                  color: widget.color ?? Colors.white,
                  decoration: widget.decoration,
                  shadows: widget.shadows,
                  height: widget.lineHeight,

                  decorationColor: widget.decorationColor,
                )
              : GoogleFonts.inter(
                  // fontFamily: "Poppins",
                  letterSpacing: widget.letterSpacing,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight ?? FontWeight.normal,
                  color: widget.color ?? Colors.white,
                  decoration: widget.decoration,
                  shadows: widget.shadows,
                  height: widget.lineHeight,

                  decorationColor: widget.decorationColor,
                )),
      softWrap: widget.softWrap,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textAlign: widget.textAlign,
    );
  }
}

class GreyCustomText extends StatefulWidget {
  final bool isPoppins;
  final text,
      fontWeight,
      color,
      overflow,
      textAlign,
      maxLines,
      letterSpacing,
      decoration,
      shadows,
      decorationColor,
      softWrap;
  final double? fontSize;
  final double? lineHeight;
  final TextStyle? style;
  const GreyCustomText(
      {this.text,
      this.letterSpacing,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.overflow,
      this.decoration,
      this.textAlign,
      this.maxLines,
      this.shadows,
      this.decorationColor,
      this.softWrap,
      this.lineHeight,
      key,
      this.isPoppins = false,
      this.style})
      : super(key: key);

  @override
  State<GreyCustomText> createState() => _GreyCustomTextState();
}

class _GreyCustomTextState extends State<GreyCustomText> {
  @override
  Widget build(BuildContext context) {
    return
        // text: widget.text,
        Text(
      widget.text,
      style: widget.style ??
          (widget.isPoppins
              ? GoogleFonts.poppins(
                  // fontFamily: "Poppins",
                  letterSpacing: widget.letterSpacing,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight ?? FontWeight.normal,
                  color: widget.color ?? const Color(0xffa1a1a1),
                  decoration: widget.decoration,
                  shadows: widget.shadows,
                  height: widget.lineHeight,

                  decorationColor: widget.decorationColor,
                )
              : GoogleFonts.inter(
                  // fontFamily: "Poppins",
                  letterSpacing: widget.letterSpacing,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight ?? FontWeight.normal,
                  color: widget.color ?? const Color(0xffa1a1a1),
                  decoration: widget.decoration,
                  shadows: widget.shadows,
                  height: widget.lineHeight,

                  decorationColor: widget.decorationColor,
                )),
      softWrap: widget.softWrap,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textAlign: widget.textAlign,
    );
  }
}

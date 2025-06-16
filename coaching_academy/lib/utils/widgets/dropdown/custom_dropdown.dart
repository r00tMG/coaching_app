import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final Color? backgroundColor;
  final Function(String?)? onChanged;
  final String? prefixIconPath;
  final Color? textColor;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    this.backgroundColor,
    this.prefixIconPath,
    required this.onChanged,
    this.textColor,
  });

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightGrey)),
      // color: AppColors.containerBackColor,
      child: DropdownButtonFormField<String>(
        // underline: const SizedBox(),
        decoration: widget.prefixIconPath == null
            ? const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              )
            : InputDecoration(
                prefixIcon: SvgPicture.asset(
                  widget.prefixIconPath!,
                  fit: BoxFit.scaleDown,
                  height: 40,
                  width: 40,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
        isExpanded: true,
        value: widget.value,
        icon: Container(
          padding: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
        ),
        items: widget.items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Container(
              padding: const EdgeInsets.only(left: 5),
              child: CustomText(
                text: item,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                isPoppins: true,
                color: widget.textColor ?? Colors.black,
              ),
            ),
          );
        }).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}

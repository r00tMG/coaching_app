import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchFilterOption extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onPress;
  const SearchFilterOption({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: SvgPicture.asset(
              iconPath,
              color: Colors.black,
            ),
          ),
          CustomText(
            text: title,
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}

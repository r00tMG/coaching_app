import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserRoleWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isSelected;

  const UserRoleWidget({
    super.key,
    required this.imagePath,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff4CD964) : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                color: isSelected ? Colors.white : Colors.black,
              ), // Or SvgPicture if using SVGs
              const SizedBox(height: 10),
              CustomText(
                text: title,
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        if (isSelected)
          const Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
          ),
      ],
    );
  }
}

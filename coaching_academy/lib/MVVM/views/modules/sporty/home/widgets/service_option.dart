import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceOption extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPress;
  final String title;
  final String status;
  final String rating;
  final String time;

  const ServiceOption({
    super.key,
    required this.onPress,
    required this.imagePath,
    required this.title,
    required this.status,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = imagePath.startsWith('http');

    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.55,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          // color: Colors.white,
          // borderRadius: BorderRadius.circular(10),
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: isNetworkImage
                  ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
              )
                  : Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            ), // Or SvgPicture if using SVGs
            // const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: AppColors.backgroundGrey,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: title,
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColors.primaryGreen,
                            size: 8,
                          ),
                          2.horizontalSpace,
                          CustomText(
                            text: status,
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: rating,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,
                            size: 15,
                            color: Colors.white,
                          ),
                          10.horizontalSpace,
                          CustomText(
                            text: time,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

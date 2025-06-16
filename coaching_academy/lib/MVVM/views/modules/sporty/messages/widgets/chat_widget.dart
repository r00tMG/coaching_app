import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final String time;
  final String subtitle;
  final String? messageCount;
  final String imagePath;
  const ChatWidget({
    super.key,
    required this.title,
    required this.time,
    required this.subtitle,
    this.messageCount,
    required this.imagePath,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Row(
            children: [
              Image.network(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
              )
              ??
              SvgPicture.asset(imagePath),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: title,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: time,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GreyCustomText(
                            text: subtitle,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          messageCount == null
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Color(0xff0D7EB1),
                                      shape: BoxShape.circle),
                                  child: const CustomText(
                                    text: "3",
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.only(left: 65), child: const Divider())
      ],
    );
  }
}

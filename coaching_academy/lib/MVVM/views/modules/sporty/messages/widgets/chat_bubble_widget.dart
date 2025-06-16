import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;
  const ChatBubbleWidget({
    super.key,
    required this.message,
    this.isMe = true,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    0.6, // Limit to 60% of screen width
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      isMe ? const Color(0xff49c646) : const Color(0xff373737),
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                ),
                child: CustomText(
                  text: message,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
            CustomText(
              text: time,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            20.verticalSpace,
          ],
        ),
      ],
    );
  }
}

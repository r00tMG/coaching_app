import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VideoScreenWidget extends StatelessWidget {
  final String videoNumber;
  final String videoDuration;
  final String imagePath;
  final String title;
  final String description;
  const VideoScreenWidget({
    super.key,
    required this.videoNumber,
    required this.videoDuration,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                child: Image.asset(
                  imagePath,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    CustomText(
                      text: "Video $videoNumber",
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                    4.horizontalSpace,
                    const Icon(
                      Icons.circle,
                      color: Color(0xffc4c4c4),
                      size: 5,
                    ),
                    4.horizontalSpace,
                    CustomText(
                      text: videoDuration,
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GreyCustomText(
                  text: description,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  // color: Colors.black,
                ),
              ),
              20.verticalSpace,
            ],
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 50,
              child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(AppImages.videoPlayIcon))),
        ],
      ),
      // Image.asset(AppImages.pic)
    );
  }
}

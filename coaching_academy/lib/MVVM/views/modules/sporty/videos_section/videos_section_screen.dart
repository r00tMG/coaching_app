import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/videos_section/widgets/video_screen_widget.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:flutter/material.dart';

class VideosSectionScreen extends StatefulWidget {
  const VideosSectionScreen({super.key});

  @override
  State<VideosSectionScreen> createState() => _VideosSectionScreenState();
}

class _VideosSectionScreenState extends State<VideosSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Fitness",
        onPress: () {
          Navigator.pop(context);
        },
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            VideoScreenWidget(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
              imagePath: AppImages.videoSectionPic2,
              title: "Lorem Ipsum",
              videoDuration: "20 Min",
              videoNumber: "1",
            ),
            VideoScreenWidget(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
              imagePath: AppImages.videoSectionPic3,
              title: "Lorem Ipsum",
              videoDuration: "30 Min",
              videoNumber: "2",
            ),
            VideoScreenWidget(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
              imagePath: AppImages.videoSectionPic2,
              title: "Lorem Ipsum",
              videoDuration: "20 Min",
              videoNumber: "3",
            ),
            VideoScreenWidget(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
              imagePath: AppImages.videoSectionPic3,
              title: "Lorem Ipsum",
              videoDuration: "30 Min",
              videoNumber: "4",
            ),
          ],
        ),
      ),
    );
  }
}

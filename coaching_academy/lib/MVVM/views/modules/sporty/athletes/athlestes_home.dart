import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/athletes/widgets/athletes_option.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/videos_section/videos_section_screen.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class AthletesHomeScreen extends StatefulWidget {
  const AthletesHomeScreen({super.key});

  @override
  State<AthletesHomeScreen> createState() => _AthletesHomeScreenState();
}

class _AthletesHomeScreenState extends State<AthletesHomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutLeading(
        title: "Athletes",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              fillColor: AppColors.backgroundGrey,
              controller: searchController,
              borderColor: Colors.transparent,
              textColor: Colors.white,
              iconColor: Colors.white,
              hintTextColor: Colors.white,
              borderRadius: 10,
              hintText: "Search here",
              iconPath: AppImages.searchIcon,
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AthletesOption(
                  imagePath: AppImages.fitnessLargeIcon,
                  onPress: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const VideosSectionScreen());
                  },
                  title: "Fitness",
                ),
                AthletesOption(
                  imagePath: AppImages.circuitTrainingLargeIcon,
                  onPress: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const VideosSectionScreen());
                  },
                  title: "Circuit Training",
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AthletesOption(
                  title: "Body Building",
                  imagePath: AppImages.circuitTrainingLargeIcon,
                  onPress: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const VideosSectionScreen());
                  },
                ),
                AthletesOption(
                  title: "Yoga",
                  imagePath: AppImages.yogaIcon,
                  onPress: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const VideosSectionScreen());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

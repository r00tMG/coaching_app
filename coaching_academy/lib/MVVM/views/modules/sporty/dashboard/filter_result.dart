import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/sporty_service_profile_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/service_option.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({super.key});

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Filter",
          onPress: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ServiceOption(
                  imagePath: AppImages.cover1,
                  onPress: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const SportyServiceProfileScreen());
                  },
                  title: "Yoga Service",
                  rating: "4.5",
                  status: "OPEN",
                  time: "10:00-12:00",
                ),
                ServiceOption(
                  imagePath: AppImages.cover2,
                  onPress: () {},
                  title: "Yoga Service",
                  rating: "4.5",
                  status: "OPEN",
                  time: "10:00-12:00",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

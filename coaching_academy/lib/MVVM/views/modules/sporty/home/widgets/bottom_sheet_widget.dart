import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/sporty_dashboard2.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/home_option.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  BottomSheetWidgetState createState() => BottomSheetWidgetState();
}

class BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff232323),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: 280, // Set the height for the bottom sheet
      child: Column(
        children: [
          10.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              width: 50,
              child: Divider(
                color: AppColors.foregroundGrey,
                thickness: 5,
                height: 10,
              ),
            ),
          ),
          10.verticalSpace,
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Image.asset(AppImages.avatar),
                10.horizontalSpace,
                Column(
                  children: [
                    const CustomText(
                      text: "Bushra Bibi",
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColors.primaryGreen,
                          size: 8,
                        ),
                        2.horizontalSpace,
                        const CustomText(
                          text: "Disponible",
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Divider(
              color: AppColors.foregroundGrey,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeOption(
                    iconPath: AppImages.fitnessIcon,
                    onPress: () {
                      PageNavigator(ctx: context).nextPage(
                          page: const SportyDashboard2(
                        indexx: 0,
                      ));
                    },
                    title: "Fitness",
                  ),
                  5.horizontalSpace,
                  HomeOption(
                    iconPath: AppImages.circuitTrainingIcon,
                    onPress: () {
                      PageNavigator(ctx: context).nextPage(
                          page: const SportyDashboard2(
                        indexx: 0,
                      ));
                    },
                    title: "Circuit Training",
                  ),
                  5.horizontalSpace,
                  HomeOption(
                    iconPath: AppImages.bodyBuildingIcon,
                    onPress: () {
                      PageNavigator(ctx: context).nextPage(
                          page: const SportyDashboard2(
                        indexx: 0,
                      ));
                    },
                    title: "Body Building",
                  ),
                ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Divider(
              color: AppColors.foregroundGrey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeOption2(
                onPress: () {
                  PageNavigator(ctx: context).nextPage(
                      page: const SportyDashboard2(
                    indexx: 0,
                  ));
                },
              ),
              HomeOption2(
                onPress: () {
                  PageNavigator(ctx: context).nextPage(
                      page: const SportyDashboard2(
                    indexx: 0,
                  ));
                },
              ),
              HomeOption2(
                onPress: () {
                  PageNavigator(ctx: context).nextPage(
                      page: const SportyDashboard2(
                    indexx: 0,
                  ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/sporty_dashboard2.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/home_option.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../models/ServiceCoachModel.dart';
import '../../dashboard/filter_result.dart';

class BottomSheetWidget extends StatefulWidget {
  final List<ServiceCoachModel> services;

  const BottomSheetWidget({required this.services});


  //const BottomSheetWidget({super.key, required this.service});

  @override
  BottomSheetWidgetState createState() => BottomSheetWidgetState();
}

class BottomSheetWidgetState extends State<BottomSheetWidget> {
  String selectedTrainingOption = '';

  @override
  void initState() {
    super.initState();
    final options = _getTrainingOptions();
    if (options.isNotEmpty) {
      selectedTrainingOption = options.first;
    }
  }

  List<String> _getTrainingOptions() {
    final allOptions = widget.services
        .expand((s) => s.workingHours)
        .map((e) => e.trainingOption)
        .toSet()
        .toList();
    return allOptions;
  }


  List<String> _getCategories() {
    return widget.services.map((s) => s.category).toSet().toList();
  }


  @override
  Widget build(BuildContext context) {
    final categories = _getCategories();
    final trainingOptions = _getTrainingOptions();

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff232323),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      height: 330,
      child: Column(
        children: [
          10.verticalSpace,
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.foregroundGrey,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          10.verticalSpace,
          // COACH HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  widget.services.first.user.profilePicture ??
                      'https://via.placeholder.com/40',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.account_circle, size: 40),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: widget.services.first.user.name),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            color: AppColors.primaryGreen, size: 8),
                        5.horizontalSpace,
                        const CustomText(text: "Disponible"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Divider(color: AppColors.foregroundGrey),
          10.verticalSpace,
          // CATEGORIES
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: HomeOption(
                    iconPath: AppImages.fitnessIcon,
                    title: category,
                    onPress: () {
                      // Tu peux ajouter une logique de filtrage par catégorie ici
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Divider(
              color: AppColors.foregroundGrey,
            ),
          ),

          // TRAINING OPTION SELECTOR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: trainingOptions.map((option) {
                return HomeOption2(
                  label: option,
                  /*onPress: () {
                    setState(() {
                      selectedTrainingOption = option;
                    });
                  },*/
                  onPress: () {
                    final filtered = widget.services.where((s) {
                      return s.workingHours.any((wh) => wh.trainingOption == option);
                    }).toList();

                    PageNavigator(ctx: context).nextPage(
                      page: FilterResultScreen(filteredServices: filtered),
                    );
                  },

                );
              }).toList(),
            ),

          /*10.verticalSpace,
          Divider(color: AppColors.foregroundGrey),

          // SERVICES LIST (affichés quel que soit l’option)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.service.coachServices.map((service) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: HomeOption(
                        iconPath: AppImages.fitnessIcon,
                        title: service.name,
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                            page: const SportyDashboard2(indexx: 0),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

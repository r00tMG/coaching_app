import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/sporty_service_profile_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/service_option.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../../../models/ServiceCoachModel.dart';

class FilterResultScreen extends StatefulWidget {
  final List<ServiceCoachModel> filteredServices;

  const FilterResultScreen({super.key, required this.filteredServices});

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
           // Navigator.pop(context);
          }),
      /*body: SingleChildScrollView(
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
      ),*/
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3, // ajuste la taille des cartes ici
            children: widget.filteredServices.map((service) {
              return ServiceOption(
                imagePath: AppImages.cover1,
                onPress: () {
                  PageNavigator(ctx: context).nextPage(
                    page: SportyServiceProfileScreen(service: service),
                  );
                },
                title: service.serviceName,
                rating: "4.5",
                status: "OPEN",
                time: service.workingHours.isNotEmpty
                    ? "${service.workingHours.first.startHour} - ${service.workingHours.first.endHour}"
                    : "N/A",
              );
            }).toList(),
          ),
        ),


    );
  }
}

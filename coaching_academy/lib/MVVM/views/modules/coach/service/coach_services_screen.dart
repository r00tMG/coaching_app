import 'dart:convert';

import 'package:coaching_academy/MVVM/models/ServiceCoachModel.dart';
import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/onboarding/service_details.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/service/coach_service_profile_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/service_option.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/WorkingHour.dart';
import '../onboarding/working_hours_screen.dart';

class CoachServicesScreen extends StatefulWidget {
  const CoachServicesScreen({super.key});

  @override
  State<CoachServicesScreen> createState() => _CoachServicesScreenState();
}

class _CoachServicesScreenState extends State<CoachServicesScreen> {
  TextEditingController searchController = TextEditingController();
  List<ServiceCoachModel> workingHours = [];
  @override
  void initState() {
    super.initState();
    fetchServiceWorkingHours();
    //print("Liste des services: $workingHours");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutLeading(title: "Services"),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            ...List.generate(
              (workingHours.length / 2).ceil(),
                  (index) {
                final firstService = workingHours[index * 2];
                final secondService = (index * 2 + 1 < workingHours.length)
                    ? workingHours[index * 2 + 1]
                    : null;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildServiceOption(firstService),
                    if (secondService != null) buildServiceOption(secondService),
                    if (secondService == null)
                      const SizedBox(width: 150), // pour équilibrer le Row si impair
                  ],
                );
              },
            ),
            // popular
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  buttonText: "Add+",
                  onPressed: () {
                    /*Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return const ServiceDetailsScreen();
                    }), (v) => false);*/
                    PageNavigator(ctx: context)
                        .nextPage(page: const ServiceDetailsScreen());
                  }),
            )
          ],
        ),
      ),
    );

  }

  Widget buildServiceOption(ServiceCoachModel service) {
    final hasHours = service.workingHours.isNotEmpty;
    final time = hasHours
        ? "${service.workingHours[0].startHour} - ${service.workingHours[0].endHour}"
        : "Non défini";
    final status = hasHours ? "OPEN" : "CLOSED";

    final imageUrl = (service.workspaceMedias.isNotEmpty &&
        service.workspaceMedias[0].workspaceImage != null)
        ? "http://localhost:8000/storage/${service.workspaceMedias[0].workspaceImage}"
        : AppImages.cover1;

    return ServiceOption(
      imagePath: imageUrl,
      onPress: () {
        PageNavigator(ctx: context).nextPage(
          page: CoachServiceProfileScreen(service: service),
        ); // à adapter
      },
      title: service.serviceName,
      rating: "4.5", // fixe ou dynamique selon ton API
      status: status,
      time: time,
    );
  }


  Future<void> fetchServiceWorkingHours() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.get(Uri.parse('http://localhost:8000/api/coach/services/workingHours'),
        headers: {
          'Accept':'application/json',
          'Authorization':'Bearer $token'
        }
    );
    print('response : ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List jsonData = data['services'];
      //print('json data: $jsonData');
      setState(() {
        workingHours = jsonData
            .map<ServiceCoachModel>((item) => ServiceCoachModel.fromJson(item))
            .toList();
        //print("Liste des services chargés: $workingHours");
      });
    } else {
      throw Exception('Échec de chargement des services');
    }
  }
}

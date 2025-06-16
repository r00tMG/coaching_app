import 'dart:convert';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/filter_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/sporty_service_profile_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/drawer_options_widget.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/widgets/service_option.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/notifications/notifications.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/profile/sporty_profile_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/subscription/subscription_step1.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/ServiceCoachModel.dart';
import '../../coach/service/coach_service_profile_screen.dart';

class SportyServices extends StatefulWidget {
  const SportyServices({super.key});

  @override
  State<SportyServices> createState() => _SportyServicesState();
}

class _SportyServicesState extends State<SportyServices> {
  TextEditingController searchController = TextEditingController();
  List<ServiceCoachModel> workingHours = [];
  String? userName;
  String? userPhotoUrl;
  String? bio;
  String? email;

  @override
  void initState() {
    super.initState();

    fetchUserInfo();
    fetchServices();
    //print("Liste des services: $workingHours");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              // const DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //   ),
              //   child: Text('Drawer Header'),
              // ),
              Column(
                children: [
                  40.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              //backgroundImage: NetworkImage(userPhotoUrl!),
                              backgroundImage: userPhotoUrl != null && userPhotoUrl!.isNotEmpty
                                  ? NetworkImage(userPhotoUrl!)
                                  : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                              radius: 40,
                            ) ,
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: userName ?? "Emma",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  CustomText(
                                    text: email ?? "emma4676@gmail.com",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              PageNavigator(ctx: context).nextPage(
                                page: const SportyProfileScreen(),
                              );
                            },
                            child: SvgPicture.asset(AppImages.editProfileIcon)),
                      ],
                    ),
                  ),
                  30.verticalSpace,
                  DrawerOptionWidget(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    imagePath: AppImages.profileHome,
                    title: "Home",
                  ),
                  20.verticalSpace,
                  DrawerOptionWidget(
                    imagePath: AppImages.profileNotifications,
                    title: "Notifications",
                    onPress: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const NotificationsScreen());
                    },
                  ),
                  20.verticalSpace,
                  DrawerOptionWidget(
                    imagePath: AppImages.profileSubscription,
                    title: "Subscriptions",
                    onPress: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const SubscriptionStep1());
                    },
                  ),
                  20.verticalSpace,
                  DrawerOptionWidget(
                    imagePath: AppImages.logoutRedIcon,
                    textColor: Colors.red,
                    title: "Logout",
                    onPress: () {
                      showLogoutBottomSheet(context);
                    },
                  ),
                ],
              ),

              200.verticalSpace,
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundGrey,
                ),
                child: SvgPicture.asset(
                  AppImages.shortLogo,
                  fit: BoxFit.scaleDown,
                  height: 20,
                ),
              ),
              10.verticalSpace,
              const Center(
                child: CustomText(
                  text: "Version 1.0",
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset(
              AppImages.drawerIcon,
              fit: BoxFit.scaleDown,
            ),
          );
        }),
        actions: [
          GestureDetector(
            onTap: () {
              PageNavigator(ctx: context)
                  .nextPage(page: const NotificationsScreen());
            },
            child: Container(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AppImages.notificationsTopIcon)),
          )
        ],
        backgroundColor: Colors.black,
        title: SvgPicture.asset(AppImages.shortLogo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // search field
            CustomTextField(
              iconPath: AppImages.searchIcon,
              iconColor: Colors.black,
              controller: searchController,
              hintText: "Find Here",
              textFontSize: 12,
              suffixIcon: GestureDetector(
                onTap: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: const FilterScreen());
                },
                child: SvgPicture.asset(
                  AppImages.filterIcon,
                  fit: BoxFit.scaleDown,
                ),
              ),
              fontWeight: FontWeight.w400,
              borderRadius: 10,
            ),
// top rated
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  CustomText(
                    text: "Top Rated",
                    isPoppins: true,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: "View all",
                    isPoppins: true,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),

                ],
              ),
            ),
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

            /*Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Popular Right Now",
                    isPoppins: true,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: "View all",
                    isPoppins: true,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ServiceOption(
                  imagePath: AppImages.cover1,
                  onPress: () {},
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
            ),*/
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

    /*final imageUrl = (service.workspaceMedias.isNotEmpty &&
        service.workspaceMedias[0].workspaceImage != null)
        ? "http://0.0.0.0:8000/storage/${service.workspaceMedias[0].workspaceImage}"
        : AppImages.cover1;*/
    final imageUrl = (service.workspaceMedias.isNotEmpty &&
        service.workspaceMedias[0].workspaceImage != null &&
        service.workspaceMedias[0].workspaceImage!.isNotEmpty)
        ? "http://localhost:8000/storage/${service.workspaceMedias[0].workspaceImage}"
        : AppImages.cover1;

    //print("image url: $imageUrl");

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
  Future<void> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('http://localhost:8000/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userName = data['name'];
        userPhotoUrl = data['profile_picture'];
        bio = data['bio'];
        email = data['email'];

        print('photo profile: $userPhotoUrl.');
      });
    } else {
      print("Erreur: ${response.statusCode}");
    }
  }

  Future<void> fetchServices() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.get(Uri.parse('http://localhost:8000/api/coach/services'),
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

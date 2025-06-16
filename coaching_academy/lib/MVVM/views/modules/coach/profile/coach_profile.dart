import 'dart:convert';

import 'package:coaching_academy/MVVM/models/ServiceModel.dart';
import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/global/contact_us/contact_us.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/posts/my_posts_screen2.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/booking/coach_booking_home.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/certificate/certificate_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/earning_and_stats/earning_and_stats.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/edit_profile/coach_edit_profile.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/terms_and_conditions/terms_and_conditions.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/auth/login/login_screen.dart';
import '../posts/my_posts_screen.dart';

class CoachProfile extends StatefulWidget {
  // Define the colors from your request
  static Color backgroundGrey = const Color(0xff333333);
  static Color primaryGreen = const Color(0xff5CFF58);

  const CoachProfile({super.key});

  @override
  State<CoachProfile> createState() => _CoachProfileState();
}

class _CoachProfileState extends State<CoachProfile> {
  bool isNotificationOn = false;
  String? userName;
  String? userPhotoUrl;
  String? bio;
  List<ServiceModel> services = [];

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchCoachServices();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundGrey,
      appBar: customAppBar(title: "My Profile", onPress: () {}),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  /*SvgPicture.asset(
                    AppImages.avatar2,
                    height: 100,
                  ),*/
                  userPhotoUrl != null
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(userPhotoUrl!),
                    radius: 40,
                  )
                      : SvgPicture.asset(AppImages.addPostsProfilePic, height: 48, width: 48),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: userName ?? 'Jurassic Remo',
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        const CustomText(
                          text: '25 years old',
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                          color: Colors.white70,
                        ),
                        const SizedBox(height: 4),
                        /*Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundGrey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: CustomText(
                                text: 'Yoga',
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                            4.horizontalSpace,
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundGrey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: CustomText(
                                text: 'Running',
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ],
                        ),*/
                        Row(
                          children: services.map((service) {
                            return Container(
                              margin: const EdgeInsets.only(right: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundGrey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: CustomText(
                                text: service.name,
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryGreen,
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 12),
                         CustomText(
                          text: bio ?? '"Lorem ipsum dolor sit amet, consectetur dip\nit tempor erat sagittis nibh eget feugiat"',
                          textAlign: TextAlign.left,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,

                          color: Colors.white70,
                          // fontStyle: FontStyle.italic,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // const SizedBox(height: 12),

              const SizedBox(height: 24),
              _buildMenuItem(
                onPress: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: const CoachEditProfileScreen());
                },
                svgImage: /*SvgPicture.asset(
                  AppImages.avatar2,
                  fit: BoxFit.scaleDown,
                  height: 20,
                ),*/userPhotoUrl != null
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(userPhotoUrl!),
                  radius: 18,
                )
                    : SvgPicture.asset(AppImages.addPostsProfilePic, height: 48, width: 48),
                //const SizedBox(width: 8),
                'Edit Profile',
                context,
              ),
              20.verticalSpace,
              _buildMenuItem(
                  onPress: () {},
                  svgImage: SvgPicture.asset(
                    AppImages.profileNotification,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Notification',
                  context,
                  trailing: Switch(
                    thumbColor: WidgetStatePropertyAll(AppColors.white),
                    value: isNotificationOn,
                    onChanged: (value) {
                      setState(() {
                        isNotificationOn = !isNotificationOn;
                      });
                    },
                    activeColor: CoachProfile.primaryGreen,
                  )),
              20.verticalSpace,

              _buildMenuItem(onPress: () {
                Share.share("text");
              },
                  svgImage: SvgPicture.asset(
                    AppImages.profileShare,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Share Profile',
                  context),
              20.verticalSpace,

              _buildMenuItem(onPress: () {
                PageNavigator(ctx: context)
                    .nextPage(page: const TermsAndConditions());
              },
                  svgImage: SvgPicture.asset(
                    AppImages.profileAboutUs,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Terms & Conditions',
                  context),
              20.verticalSpace,

              _buildMenuItem(onPress: () {
                PageNavigator(ctx: context)
                    .nextPage(page: const CoachBookingHomeScreen());
              },
                  svgImage: SvgPicture.asset(
                    AppImages.myBooking,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'My Booking',
                  context),
              20.verticalSpace,

              _buildMenuItem(onPress: () {
                PageNavigator(ctx: context).nextPage(page: const ContactUs());
              },
                  svgImage: SvgPicture.asset(
                    AppImages.profileContactUs,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Contact Us',
                  context),
              20.verticalSpace,

              _buildMenuItem(onPress: () {
                PageNavigator(ctx: context)
                    .nextPage(page: const CertificateScreen());
              },
                  svgImage: SvgPicture.asset(
                    AppImages.certificateIcon,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Diplomas/Certifications',
                  context),
              20.verticalSpace,
              _buildMenuItem(onPress: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor:
                      const Color(0xff333333), // Set background color
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (BuildContext context) {
                    return buildBottomSheetContent(context);
                  },
                );
              },
                  svgImage: SvgPicture.asset(
                    AppImages.trainingOptions,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Training Options',
                  context),
              20.verticalSpace,
              _buildMenuItem(onPress: () {
                PageNavigator(ctx: context).nextPage(
                  page: const EarningStatsScreen(),
                );
              },
                  svgImage: SvgPicture.asset(
                    AppImages.earningAndStats,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Earning & Stats',
                  context),
              20.verticalSpace,
              _buildMenuItem(onPress: () {
                PageNavigator(ctx: context).nextPage(
                  page: const MyPostsScreen(),
                );
              },
                  svgImage: SvgPicture.asset(
                    AppImages.myPostsIcon,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'My Posts',
                  context),
              20.verticalSpace,

              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  // primary: Colors.black,
                  backgroundColor: AppColors.backgroundGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () async {
                  showLogoutBottomSheet(context);
                },
                icon: SvgPicture.asset(
                  AppImages.profileLogout,
                ),
                label: const CustomText(
                  text: 'Log Out',
                  // color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for each menu item
  Widget _buildMenuItem(String title, BuildContext context,
      {Widget? trailing,
      Widget? svgImage,
      IconData? icon,
      required VoidCallback onPress}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(
              10)), // padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: svgImage ?? Icon(icon, color: Colors.white),
        title: CustomText(
          text: title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: trailing ??
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
        tileColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: onPress,
      ),
    );
  }

  Future<void> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('http://0.0.0.0:8000/api/user'),
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
        print('photo profile: $userPhotoUrl');
      });
    } else {
      print("Erreur: ${response.statusCode}");
    }
  }


  Future<void> fetchCoachServices() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.get(Uri.parse('http://0.0.0.0:8000/api/coach/services'),
    headers: {
      'Accept':'application/json',
      'Authorization':'Bearer $token'
    }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List jsonData = data['services'];
      setState(() {
        services = jsonData.map<ServiceModel>((item) => ServiceModel.fromJson(item))
            .toList();
      });
    } else {
      throw Exception('Échec de chargement des services');
    }
  }
}

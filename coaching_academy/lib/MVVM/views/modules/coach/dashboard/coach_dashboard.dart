import 'package:coaching_academy/MVVM/views/modules/coach/diary/diary_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/notifications/coach_notifications.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/posts/create_post_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/coach_profile.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/service/coach_services_screen.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CoachDashboard extends StatefulWidget {
  const CoachDashboard({
    super.key,
  });

  @override
  State<CoachDashboard> createState() => _CoachDashboardState();
}

class _CoachDashboardState extends State<CoachDashboard> {
  bool isLocationEmpty = false;

  int pageIndex = 0;
  final pages = [
    const DiaryScreen(),
    const CoachNotifications(),
    const CreatePostScreen(),
    const CoachServicesScreen(),
    const CoachProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xff333333),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 35,
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    icon: pageIndex == 0
                        ? SvgPicture.asset(
                            AppImages.diaryIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.diaryIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Diary",
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: pageIndex == 0
                          ? AppColors.primaryGreen
                          : Colors.white),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 35,
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                    icon: pageIndex == 1
                        ? SvgPicture.asset(
                            AppImages.notificationIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.notificationIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Notifications",
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: pageIndex == 1
                          ? AppColors.primaryGreen
                          : Colors.white),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 55,
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                    icon: SvgPicture.asset(
                      AppImages.addPostsIcon,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 35,
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 3;
                      });
                    },
                    icon: pageIndex == 3
                        ? SvgPicture.asset(
                            AppImages.serviceIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.serviceIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Service",
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: pageIndex == 3
                          ? AppColors.primaryGreen
                          : Colors.white),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 35,
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 4;
                      });
                    },
                    icon: pageIndex == 4
                        ? SvgPicture.asset(
                            AppImages.profileIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.profileIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Profile",
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: pageIndex == 4
                          ? AppColors.primaryGreen
                          : Colors.white),
                )
              ],
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: const Color(0xff333333),
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: IconButton(
      //         enableFeedback: false,
      //         onPressed: () {
      //           setState(() {
      //             pageIndex = 0;
      //           });
      //         },
      //         icon: pageIndex == 0
      //             ? SvgPicture.asset(
      //                 AppImages.searchIcon,
      //                 color: AppColors.primaryGreen,
      //                 // height: 25,
      //               )
      //             : SvgPicture.asset(
      //                 AppImages.searchIcon,
      //               ),
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //           enableFeedback: false,
      //           onPressed: () {
      //             setState(() {
      //               pageIndex = 1;
      //             });
      //           },
      //           icon: pageIndex == 1
      //               ? SvgPicture.asset(
      //                   AppImages.messageIcon,
      //                   color: AppColors.primaryGreen,
      //                 )
      //               : SvgPicture.asset(
      //                   AppImages.searchIcon,
      //                 ),
      //         ),
      //         label: 'Messages'),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //           enableFeedback: false,
      //           onPressed: () {
      //             setState(() {
      //               pageIndex = 2;
      //             });
      //           },
      //           icon: pageIndex == 2
      //               ? SvgPicture.asset(
      //                   AppImages.bookingIconSvg,
      //                   color: AppColors.primaryGreen,
      //                 )
      //               : SvgPicture.asset(
      //                   AppImages.bookingIconSvg,
      //                 ),
      //         ),
      //         label: 'Booking'),
      //     BottomNavigationBarItem(
      //         icon: IconButton(
      //           enableFeedback: false,
      //           onPressed: () {
      //             setState(() {
      //               pageIndex = 2;
      //             });
      //           },
      //           icon: pageIndex == 2
      //               ? SvgPicture.asset(
      //                   AppImages.bookingIconSvg,
      //                   color: AppColors.primaryGreen,
      //                 )
      //               : SvgPicture.asset(
      //                   AppImages.bookingIconSvg,
      //                 ),
      //         ),
      //         label: 'Athletes'),
      //   ],
      // ),
    );
  }
}

import 'package:coaching_academy/MVVM/views/modules/sporty/athletes/athlestes_home.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/booking/booking_home.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/home/sporty_home_map_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/messages_home.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/posts/posts_screen.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SportyDashboard extends StatefulWidget {
  const SportyDashboard({
    super.key,
  });

  @override
  State<SportyDashboard> createState() => _SportyDashboardState();
}

class _SportyDashboardState extends State<SportyDashboard> {
  bool isLocationEmpty = false;

  int pageIndex = 0;
  final pages = [
    const SportyHomeMapScreen(),
    const MessagesHome(),
    const BookingHomeScreen(),
    const PostsScreen(),
    const AthletesHomeScreen()
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
                            AppImages.searchIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.searchIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Research",
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
                            AppImages.messageIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.messageIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Messages",
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
                  height: 35,
                  child: IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                    icon: pageIndex == 2
                        ? SvgPicture.asset(
                            AppImages.bookingIconSvg,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.bookingIconSvg,
                          ),
                  ),
                ),
                CustomText(
                  text: "Booking",
                  style: GoogleFonts.leagueSpartan(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: pageIndex == 2
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
                        pageIndex = 3;
                      });
                    },
                    icon: pageIndex == 3
                        ? SvgPicture.asset(
                            AppImages.postsIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.postsIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Posts",
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
                            AppImages.athleteIcon,
                            color: AppColors.primaryGreen,
                          )
                        : SvgPicture.asset(
                            AppImages.athleteIcon,
                          ),
                  ),
                ),
                CustomText(
                  text: "Athletes",
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

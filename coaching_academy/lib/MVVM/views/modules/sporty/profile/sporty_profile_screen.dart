import 'package:coaching_academy/MVVM/views/global/about_us/about_us.dart';
import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/global/contact_us/contact_us.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/bank_details/bank_details.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/bank_details/bank_details_main_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/profile/edit_profile.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/subscription/subscription_step1.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class SportyProfileScreen extends StatefulWidget {
  // Define the colors from your request
  static Color backgroundGrey = const Color(0xff333333);
  static Color primaryGreen = const Color(0xff5CFF58);

  const SportyProfileScreen({super.key});

  @override
  State<SportyProfileScreen> createState() => _SportyProfileScreenState();
}

class _SportyProfileScreenState extends State<SportyProfileScreen> {
  bool isNotificationOn = false;
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
                  SvgPicture.asset(
                    AppImages.avatar2,
                    height: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Jurassic Remo',
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundGrey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const CustomText(
                            text: 'Beginner',
                            fontSize: 7,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFF6C02),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const CustomText(
                          text:
                              '"Lorem ipsum dolor sit amet, consectetur dip\nit tempor erat sagittis nibh eget feugiat"',
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
                      .nextPage(page: const EditProfileScreen());
                },
                svgImage: SvgPicture.asset(
                  AppImages.profileAvatar,
                  fit: BoxFit.scaleDown,
                  height: 20,
                ),
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
                    activeColor: SportyProfileScreen.primaryGreen,
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
                PageNavigator(ctx: context).nextPage(page: const AboutUs());
              },
                  svgImage: SvgPicture.asset(
                    AppImages.profileAboutUs,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'About Us',
                  context),
              20.verticalSpace,

              _buildMenuItem(onPress: () {
                PageNavigator(ctx: context).nextPage(
                    page: BankDetailsMainScreen(
                  onAddPress: () {
                    PageNavigator(ctx: context).nextPage(page: BankDetailsPage(
                      onSavePress: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ));
                  },
                ));
              },
                  svgImage: SvgPicture.asset(
                    AppImages.profilePaymentMethod,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Payment Method',
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
                    .nextPage(page: const SubscriptionStep1());
              },
                  svgImage: SvgPicture.asset(
                    AppImages.editSubscription,
                    fit: BoxFit.scaleDown,
                    height: 20,
                  ),
                  'Edit Subscription',
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
                onPressed: () {
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
}

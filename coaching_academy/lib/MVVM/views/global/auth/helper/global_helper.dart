import 'package:coaching_academy/MVVM/views/global/auth/login/login_screen.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/divider/dotted_divider.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Row topHeader(BuildContext context) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xff353535),
          ),
          child: SvgPicture.asset(
            AppImages.backArrow,
            color: Colors.white,
          ),
        ),
      ),
      80.horizontalSpace,
      SvgPicture.asset(
        AppImages.shortLogo,
        fit: BoxFit.scaleDown,
        // height: 200,
      )
    ],
  );
}

Row heading(String text) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 20),
        child: CustomText(
          text: text,
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
          color: const Color(0xffcecece),
        ),
      ),
    ],
  );
}

void showWhitePopup({
  required BuildContext context,
  required String title,
  required String description,
  required String buttonText,
  required VoidCallback onPress,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SvgPicture.asset(AppImages.celebrateIcon)),
              20.verticalSpace,
              Center(
                child: CustomText(
                  text: title,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              CustomText(
                text: description,
                fontSize: 16,
                color: Colors.black54,
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                    backgroundColor: Colors.black,
                    buttonText: buttonText,
                    textColor: Colors.white,
                    onPressed: onPress),
              ),
            ],
          ),
        ),
      );
    },
  );
}

AppBar customAppBar(
    {required String title, required VoidCallback onPress, bool? centerTitle}) {
  return AppBar(
    backgroundColor: Colors.black,
    leading: GestureDetector(
      onTap: onPress,
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    ),
    title: CustomText(
      text: title,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    centerTitle: centerTitle ?? true,
  );
}

AppBar customAppBarWithArrow({required BuildContext context, Widget? title}) {
  return AppBar(
    backgroundColor: Colors.black,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SvgPicture.asset(
        AppImages.backArrow2,
        color: Colors.white,
        fit: BoxFit.scaleDown,
      ),
    ),
    title: title ??
        SvgPicture.asset(
          AppImages.shortLogo,
          fit: BoxFit.scaleDown,
          // height: 200,
        ),
    centerTitle: true,
  );
}

AppBar customAppBarWithoutLeading({
  required String title,
}) {
  return AppBar(
    backgroundColor: Colors.black,
    leading: const SizedBox(),
    leadingWidth: 0,
    title: CustomText(
      text: title,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    centerTitle: true,
  );
}

// service profile screen

Widget buildImageCarouselItem(String imageUrl) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(imageUrl, width: 80, height: 50, fit: BoxFit.cover),
    ),
  );
}

Widget buildServiceTile(String title, String duration, String price) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              isPoppins: true,
            ),
            CustomText(
              text: duration,
              color: Colors.black,
              isPoppins: true,
            ),
          ],
        ),
        CustomText(
          text: price,
          color: Colors.black,
          isPoppins: true,
          fontWeight: FontWeight.bold,
        ),
      ],
    ),
  );
}

// Widget buildNewBookingTile(String title, String duration, String price) {
//   return Container(
//     margin: const EdgeInsets.symmetric(vertical: 8),
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(8),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(
//               text: title,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               isPoppins: true,
//             ),
//             CustomText(
//               text: duration,
//               color: Colors.black,
//               isPoppins: true,
//             ),
//           ],
//         ),
//         CustomText(
//           text: price,
//           color: Colors.black,
//           isPoppins: true,
//           fontWeight: FontWeight.bold,
//         ),
//       ],
//     ),
//   );
// }

// bank details screen

Widget buildTextField(String label) {
  return TextField(
    style: GoogleFonts.poppins(color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: const Color(0xff222222),
    ),
  );
}

Widget buildSaveButton(
    {required BuildContext context, required VoidCallback onPress}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        // primary: Colors.white,
        // onPrimary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const CustomText(
        text: 'Save',
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// filter screen
Widget filterHeading(String text) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomText(
          text: text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

// dashboard

// import 'package:flutter/material.dart';

void showLogoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.backgroundGrey, // Your custom color
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Make the bottom sheet take minimal height
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Title
            const CustomText(
              text: 'Logout',
              isPoppins: true,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 20),
            // Content
            const CustomText(
              text: 'Are you sure you want to logout?',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              isPoppins: true,
            ),
            const SizedBox(height: 30),
            const Divider(color: Colors.white30), // Optional Divider
            const SizedBox(height: 10),
            // Actions (Cancel and Yes, Logout buttons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: const CustomText(
                    text: 'Cancel',
                    color: Colors.white,
                    isPoppins: true,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Yes, Logout Button
                ElevatedButton(
                  onPressed: () async {
                    /*Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen(); // Replace with your login screen
                    }), (v) => false);*/
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('auth_token'); // ou prefs.clear() si tu veux tout réinitialiser
                    // Ensuite on redirige vers la page de login
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      // primary: Colors.white, // White background
                      // onPrimary: Colors.black, // Black text
                      ),
                  child: const CustomText(
                    text: "Yes, Logout",
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

// subscription

Widget cancelSubscriptionDialog(BuildContext context) {
  return Dialog(
    backgroundColor: Colors.grey[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // Ensures the dialog takes up only as much space as it needs
        children: [
          CustomText(
            text: "Are you sure you want to Cancel your Subscription",
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white38),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Back Button
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Closes the dialog
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: CustomText(
                  text: "Back",
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              // Confirm Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  // primary: Colors.white, // Button background color
                  // onPrimary: Colors.black, // Text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: CustomText(
                  text: "Confirm",
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

// training options

Widget buildBottomSheetContent(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xff333333), // Background color for the bottom sheet
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: CustomText(
            text: "Select Options",
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            isPoppins: true,
          ),
        ),
        const SizedBox(height: 16),
        buildOptionTile("Gym", context),
        buildOptionTile("At Home", context),
        buildOptionTile("Room", context),
        buildOptionTile("Outside", context),
      ],
    ),
  );
}

Widget buildOptionTile(String title, context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xff4f4f4f), // Container color for each option
      borderRadius: BorderRadius.circular(8),
    ),
    child: CustomText(
      text: title,
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      isPoppins: true,
    ),
  );
}

// earning and stats

void showWithdrawPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Auto-dismiss after 3 seconds
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
        Navigator.of(context).pop(true);
      });

      return Dialog(
        backgroundColor: const Color(0xFFD2BEBE), // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Withdraw Details",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Withdraw Amount",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomText(
                      text: "\$1000",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              20.verticalSpace,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: const CustomDottedDivider(
                  color: Colors.grey,
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Date",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                  GreyCustomText(
                    text:
                        DateFormat("dd MMMM yyyy").format(DateTime(2022, 3, 3)),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    isPoppins: true,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Time",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                  const GreyCustomText(
                    text: "11:00 AM",
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    isPoppins: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/subscription/subscription_step2.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionStep1 extends StatelessWidget {
  const SubscriptionStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Fees Plan",
          centerTitle: false,
          onPress: () {
            Navigator.pop(context);
          }),
      body: const SubscriptionBody(),
    );
  }
}

class SubscriptionBody extends StatefulWidget {
  const SubscriptionBody({super.key});

  @override
  _SubscriptionBodyState createState() => _SubscriptionBodyState();
}

class _SubscriptionBodyState extends State<SubscriptionBody> {
  int _selectedPlan = 2; // Default selected yearly plan
  int _selectedPaymentMethod = 1; // Default selected Credit Card

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreyCustomText(
            text: "Get started with easy payments",
            style: GoogleFonts.urbanist(
                color: const Color(0xff797979),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          10.verticalSpace,
          CustomText(
            text: "Select",
            style: GoogleFonts.urbanist(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          10.verticalSpace,
          GreyCustomText(
            text: "Select what suits you best",
            style: GoogleFonts.urbanist(
                color: const Color(0xff797979),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          _buildPlanOption(1, "\$4.99 billed monthly"),
          30.verticalSpace,
          _buildPlanOption(2, "\$49.99 billed yearly", isBestValue: true),
          const SizedBox(height: 30),
          CustomText(
            text: "Select Payment Method",
            style: GoogleFonts.urbanist(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          GreyCustomText(
            text: "Select your preferred one",
            style: GoogleFonts.urbanist(
                color: const Color(0xff797979),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 10),
          _buildPaymentMethod(
              1, "Credit Card", AppImages.mastercardLogo, Colors.red),
          10.verticalSpace,
          _buildPaymentMethod(2, "PayPal", AppImages.paypalLogo, Colors.blue),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              PageNavigator(ctx: context)
                  .nextPage(page: const SubscriptionStep2());
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              foregroundColor: Colors.black, backgroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50), // Full-width button
            ),
            child: CustomText(
              text: "Pay & Continue",
              style: GoogleFonts.urbanist(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanOption(int value, String title, {bool isBestValue = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _selectedPlan == value
                ? Colors.green
                : AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: CustomText(
              text: title,
              style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16),
            ),
            trailing: _selectedPlan == value
                ? const Icon(FontAwesomeIcons.circleCheck, color: Colors.white)
                : null, // Show check icon only if this option is selected
            onTap: () {
              setState(() {
                _selectedPlan = value; // Update selected plan
              });
            },
          ),
        ),
        if (isBestValue)
          Positioned(
            top: -12,
            right: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.primaryGreen, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: CustomText(
                text: "Best Value",
                color: AppColors.primaryGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentMethod(
      int value, String title, String iconPath, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: SvgPicture.asset(iconPath),
        title: CustomText(
          text: title,
          style: GoogleFonts.urbanist(color: Colors.white, fontSize: 16),
        ),
        trailing: Radio(
          value: value,
          groupValue: _selectedPaymentMethod,
          onChanged: (int? newValue) {
            setState(() {
              _selectedPaymentMethod = newValue!;
            });
          },
          activeColor: AppColors.primaryGreen,
        ),
      ),
    );
  }
}

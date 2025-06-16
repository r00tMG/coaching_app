import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionStep4 extends StatelessWidget {
  const SubscriptionStep4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Subscription",
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
  final int _selectedPlan = 2; // Default selected yearly plan
  int _selectedPaymentMethod = 1; // Default selected Credit Card

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.wallet),
          30.verticalSpace,
          const GreyCustomText(
            text:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel nec sit turpis amet arcu arcu. Ultricies nec eget ut integer lacus. Adipiscing adipiscing non felis id hendrerit enim nulla diam cursus. Netus velit in ",
            fontSize: 12,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w500,
          ),
          40.verticalSpace,
          _buildPlanOption(1, "\$4.99 billed monthly"),
          30.verticalSpace,
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: CustomText(
                    text: "\$4.99 billed monthly",
                    style:
                        GoogleFonts.urbanist(color: Colors.black, fontSize: 16),
                  ),
                  trailing: const Icon(
                    FontAwesomeIcons.circleCheck,
                    color: Colors.black,
                  ),
                  // Show check icon only if this option is selected
                  onTap: () {
                    // setState(() {
                    //   _selectedPlan = value; // Update selected plan
                    // });
                  },
                ),
              ),
              Positioned(
                top: -12,
                right: 50,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 22),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    // border: Border.all(color: AppColors.primaryGreen, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CustomText(
                    text: "Paid",
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          20.verticalSpace,
          Center(
            child: CustomText(
              text:
                  "By purchasing, you agree to our Terms of Use and Privacy Policy.",
              fontSize: 11,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.white,
            ),
          ),
          const Spacer(),
          // 50.verticalSpace,
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              foregroundColor: Colors.black, backgroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50), // Full-width button
            ),
            child: CustomText(
              text: "Continue",
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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
                ? AppColors.backgroundGrey
                : AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: CustomText(
              text: title,
              style: GoogleFonts.urbanist(
                  color: _selectedPlan == value ? Colors.white : Colors.black,
                  fontSize: 16),
            ),
            trailing: _selectedPlan == value
                ? const Icon(FontAwesomeIcons.circleCheck, color: Colors.white)
                : null, // Show check icon only if this option is selected
            onTap: () {
              // setState(() {
              //   _selectedPlan = value; // Update selected plan
              // });
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
                color: AppColors.backgroundGrey,
                // border: Border.all(color: AppColors.primaryGreen, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: CustomText(
                text: "Paid",
                color: AppColors.black,
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

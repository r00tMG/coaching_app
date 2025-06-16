import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/subscription/subscription_step3.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/subscription/widgets/pricing_card.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionStep2 extends StatelessWidget {
  const SubscriptionStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Additional Search",
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
  final int _selectedPaymentMethod = 1; // Default selected Credit Card

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
          const PricingCard(),
          const Spacer(),
          // 50.verticalSpace,
          ElevatedButton(
            onPressed: () {
              PageNavigator(ctx: context)
                  .nextPage(page: const SubscriptionStep3());
            },
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
          20.verticalSpace,
          Center(
            child: CustomText(
              text:
                  "By purchasing, you agree to our Terms of Use and Privacy Policy.",
              fontSize: 11,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.primaryGreen,
            ),
          )
        ],
      ),
    );
  }
}

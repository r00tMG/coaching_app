import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/dashboard/sporty_dashboard2.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetailsMainScreen extends StatelessWidget {
  final VoidCallback onAddPress;
  const BankDetailsMainScreen({super.key, required this.onAddPress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Bank Details",
          onPress: () {
            Navigator.pop(context);
          }),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    SvgPicture.asset(AppImages.frenchBank),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Bank Name",
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CustomText(
                          text: "Ali Hassan",
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        CustomText(
                          text: "Account Number",
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              50.verticalSpace,
              CustomButton(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                buttonHeight: 45,
                buttonText: "Pay",
                onPressed: () {
                  // PageNavigator(ctx: context)
                  //     .nextPage(page: const SportyDashboard2(indexx: 2));
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const SportyDashboard2(indexx: 2);
                  }), (v) => false);
                },
              ),
              100.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      onPressed: onAddPress,
                      child: CustomText(
                        text: "Add+",
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

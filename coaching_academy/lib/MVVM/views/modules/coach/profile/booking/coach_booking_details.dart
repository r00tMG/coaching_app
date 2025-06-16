import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/booking/cancel_booking.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/divider/dotted_divider.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class CoachBookingDetailsScreen extends StatefulWidget {
  final int? status;
  const CoachBookingDetailsScreen({super.key, this.status});

  @override
  State<CoachBookingDetailsScreen> createState() =>
      _CoachBookingDetailsScreenState();
}

class _CoachBookingDetailsScreenState extends State<CoachBookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Booking Details",
        onPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Name",
                            color: AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          GreyCustomText(
                            text: "Jon Doe",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(80, 30),
                              backgroundColor: AppColors.primaryGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: CustomText(
                            text: "Indoor",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            isPoppins: true,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Bookine ID#",
                            color: AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          GreyCustomText(
                            text: "121426126",
                            color: AppColors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                      CustomText(
                        text: "QAR 50",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                  // const DottedDivider()
                  20.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: const CustomDottedDivider(),
                  ),
                  20.verticalSpace,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Session",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      GreyCustomText(
                        text: "1 hour",
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  10.verticalSpace,

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "For",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      GreyCustomText(
                        text: "mixed",
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  10.verticalSpace,

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Date",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      CustomText(
                        text: "03 March 2022",
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Time",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: "11:00 AM - 12:00 PM",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctx: context)
                              .nextPage(page: const CancelBookingScreen());
                        },
                        child: const CustomText(
                          text: "Cancel Booking?",
                          color: Color(0xffff0000),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

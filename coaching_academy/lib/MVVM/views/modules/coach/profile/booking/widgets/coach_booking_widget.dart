import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoachBookingWidget extends StatelessWidget {
  final String bookingId;
  final String userName;
  final String serviceName;
  final String price;
  final int status;
  final VoidCallback onPress;
  const CoachBookingWidget({
    super.key,
    required this.bookingId,
    required this.userName,
    required this.serviceName,
    required this.price,
    required this.status,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Booking",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      isPoppins: true,
                    ),
                    GreyCustomText(
                      text: "23 feb 2022, 12:30pm",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      isPoppins: true,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  AppImages.profileAvatar,
                  fit: BoxFit.scaleDown,
                  height: 20,
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppImages.greyRectangle),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Training Name",
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    GreyCustomText(
                      text: "QAR 30.00",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    )
                  ],
                ),
                status == 1
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff04BC00),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: CustomText(
                          text: "Complete",
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          isPoppins: true,
                        ))
                    : status == -1
                        ? ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffFF7D7D),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: CustomText(
                              text: "Cancelled",
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              isPoppins: true,
                            ))
                        : ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: CustomText(
                              text: "Pending",
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              isPoppins: true,
                            ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

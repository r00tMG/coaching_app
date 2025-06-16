import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class SportyBookingWidget extends StatelessWidget {
  final String bookingId;
  final String userName;
  final String serviceName;
  final String price;
  final int status;
  final VoidCallback onPress;
  const SportyBookingWidget({
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Booking ID#",
                      color: AppColors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    GreyCustomText(
                      text: bookingId,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    )
                  ],
                ),
                status == 0
                    ? ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff04BC00),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: CustomText(
                          text: "Accepted",
                          color: AppColors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          isPoppins: true,
                        ))
                    : status == 1
                        ? ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff04BC00),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: CustomText(
                              text: "Completed",
                              color: AppColors.black,
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                              isPoppins: true,
                            ))
                        : status == -1
                            ? ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffff3f3f),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: CustomText(
                                  text: "Cancelled",
                                  color: AppColors.black,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  isPoppins: true,
                                ))
                            : ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffFE9D2C),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: CustomText(
                                  text: "pending confirmation",
                                  color: AppColors.black,
                                  fontSize: 9,
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
                      text: userName,
                      color: AppColors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    GreyCustomText(
                      text: serviceName,
                      color: AppColors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
                CustomText(
                  text: "\$$price",
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

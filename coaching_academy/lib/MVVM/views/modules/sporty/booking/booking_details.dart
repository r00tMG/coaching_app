import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/divider/dotted_divider.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingDetailsScreen extends StatefulWidget {
  final int status;
  const BookingDetailsScreen({super.key, required this.status});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
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
                            text: "Booking ID#",
                            color: AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          GreyCustomText(
                            text: "bookingId",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          )
                        ],
                      ),
                      widget.status == 0
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
                          : widget.status == 1
                              ? ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff04BC00),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: CustomText(
                                    text: "Completed",
                                    color: AppColors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                    isPoppins: true,
                                  ))
                              : widget.status == -1
                                  ? ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffff3f3f),
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
                                          backgroundColor:
                                              const Color(0xffFE9D2C),
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
                            text: "Robert Fox",
                            color: AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          GreyCustomText(
                            text: "Services Name",
                            color: AppColors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                      CustomText(
                        text: "\$30",
                        color: AppColors.black,
                        fontSize: 12,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.maleSign),
                              const CustomText(
                                text: "Male",
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  10.verticalSpace,
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
                  10.verticalSpace,
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Location",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      CustomText(
                        text: "?",
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.status == -1
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Reason",
                          color: Color(0xffff3f3f),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        5.verticalSpace,
                        const CustomText(
                          text:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis duis dictum a facilisis. Pretium integer ultricies aliquam, viverra metus.",
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                        10.verticalSpace,
                        const CustomText(
                          text: "Suggested Date",
                          color: Color(0xffff3f3f),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        5.verticalSpace,
                        const CustomText(
                          text: "04 March 2022",
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                        10.verticalSpace,
                        const CustomText(
                          text: "Time",
                          color: Color(0xffff3f3f),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        5.verticalSpace,
                        const CustomText(
                          text: "11:00",
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {},
                            child: const CustomText(
                              text: "Book Again",
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

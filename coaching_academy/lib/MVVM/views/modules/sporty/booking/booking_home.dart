import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/booking/booking_details.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/booking/widgets/sporty_booking_widget.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class BookingHomeScreen extends StatefulWidget {
  const BookingHomeScreen({super.key});

  @override
  State<BookingHomeScreen> createState() => _BookingHomeScreenState();
}

class _BookingHomeScreenState extends State<BookingHomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutLeading(
        title: "Booking",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(child: ,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: AppColors.backgroundGrey,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      decoration: BoxDecoration(
                          color: currentIndex == 0
                              ? Colors.white
                              : const Color(0xffa0a0a0),
                          borderRadius: BorderRadius.circular(10)),
                      child: const CustomText(
                        text: "Current Booking",
                        textAlign: TextAlign.center,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      decoration: BoxDecoration(
                          color: currentIndex == 1
                              ? Colors.white
                              : const Color(0xffa0a0a0),
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomText(
                        textAlign: TextAlign.center,
                        text: "Past Booking",
                        color: currentIndex == 1 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            currentIndex == 0
                ? Column(
                    children: [
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: 0,
                          ));
                        },
                        status: 0,
                        bookingId: "121426167",
                        // isAccepted: true,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: 2,
                          ));
                        },

                        status: 2,
                        bookingId: "121426167",
                        // isAccepted: false,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: 2,
                          ));
                        },
                        bookingId: "121426167",
                        status: 2,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: 2,
                          ));
                        },
                        bookingId: "121426167",
                        status: 2,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: 1,
                          ));
                        },

                        status: 1,
                        bookingId: "121426167",
                        // isAccepted: true,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: 1,
                          ));
                        },

                        status: 1,
                        bookingId: "121426167",
                        // isAccepted: false,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: -1,
                          ));
                        },
                        bookingId: "121426167",
                        status: -1,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      SportyBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const BookingDetailsScreen(
                            status: -1,
                          ));
                        },
                        bookingId: "121426167",
                        status: -1,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

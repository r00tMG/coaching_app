import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/booking/coach_booking_details.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/booking/widgets/coach_booking_widget.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../models/BookingModel.dart';
import 'booking_service.dart';

class CoachBookingHomeScreen extends StatefulWidget {
  const CoachBookingHomeScreen({super.key});

  @override
  State<CoachBookingHomeScreen> createState() => _CoachBookingHomeScreenState();
}

/*class _CoachBookingHomeScreenState extends State<CoachBookingHomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Booking",
        onPress: () {
          Navigator.pop(context);
        },
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
                        text: "New Bookings",
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
                        text: "Past Bookings",
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
                      CoachBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const CoachBookingDetailsScreen(
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
                      CoachBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const CoachBookingDetailsScreen(
                            status: 2,
                          ));
                        },
                        bookingId: "121426167",
                        status: 2,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      CoachBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const CoachBookingDetailsScreen(
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
                      CoachBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const CoachBookingDetailsScreen(
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
                      CoachBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const CoachBookingDetailsScreen(
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
                      CoachBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const CoachBookingDetailsScreen(
                            status: -1,
                          ));
                        },
                        bookingId: "121426167",
                        status: -1,
                        serviceName: "Services Name",
                        price: "30",
                        userName: "Robert Fox",
                      ),
                      CoachBookingWidget(
                        onPress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: const CoachBookingDetailsScreen(
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
}*/
class _CoachBookingHomeScreenState extends State<CoachBookingHomeScreen> {
  int currentIndex = 0;
  late Future<List<BookingModel>> bookingsFuture;

  @override
  void initState() {
    super.initState();
    bookingsFuture = BookingService.fetchBookings(status: currentIndex);
  }

  void _reloadBookings() {
    setState(() {
      bookingsFuture = BookingService.fetchBookings(status: currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Booking",
        onPress: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: FutureBuilder<List<BookingModel>>(
              future: bookingsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erreur : ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Aucune réservation trouvée"));
                }

                final bookings = snapshot.data!;
                return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return CoachBookingWidget(
                      onPress: () {
                        PageNavigator(ctx: context).nextPage(
                          page: CoachBookingDetailsScreen(status: booking.status),
                        );
                      },
                      bookingId: booking.id,
                      status: booking.status,
                      serviceName: booking.serviceName,
                      price: booking.price,
                      userName: booking.userName,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(2, (i) => _buildTab(i)),
      ),
    );
  }

  Widget _buildTab(int index) {
    final titles = ["New Bookings", "Past Bookings"];
    return GestureDetector(
      onTap: () {
        currentIndex = index;
        _reloadBookings();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.white : const Color(0xffa0a0a0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomText(
          text: titles[index],
          textAlign: TextAlign.center,
          color: currentIndex == index ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

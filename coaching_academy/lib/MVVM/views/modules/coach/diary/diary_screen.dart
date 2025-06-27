import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/profile/booking/coach_booking_details.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../models/DiaryEvent.dart';
import 'api_service.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  DiaryScreenState createState() => DiaryScreenState();
}

class DiaryScreenState extends State<DiaryScreen> {
  DateTime _selectedDay = DateTime.now(); // Default to the current day
  bool _isDateSelected = false; // Initially no date is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBarWithoutLeading(title: "Diary"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Search Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  border: InputBorder.none,
                  icon: SvgPicture.asset(
                    AppImages.searchIcon,
                    color: Colors.white,
                  ),
                ),
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),

            // Calendar Widget
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TableCalendar(
                focusedDay: _selectedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: GoogleFonts.poppins(color: Colors.black),
                  weekendTextStyle: GoogleFonts.poppins(color: Colors.black),
                  outsideDaysVisible: false,
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: GoogleFonts.poppins(color: Colors.black),
                  leftChevronIcon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Color(0xff54738E), shape: BoxShape.circle),
                      child:
                          const Icon(Icons.chevron_left, color: Colors.white)),
                  rightChevronIcon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Color(0xff54738E), shape: BoxShape.circle),
                      child:
                          const Icon(Icons.chevron_right, color: Colors.white)),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                /*onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _isDateSelected = true; // Show the event container
                  });
                },*/
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                  _loadEvents(selectedDay);
                },

              ),
            ),
            const SizedBox(height: 20),

            // Conditionally display the event container only when a date is selected
            /*_isDateSelected
                ? Expanded(
                    child: ListView(
                      children: [
                        _buildEventContainer(
                          onPress: () {
                            PageNavigator(ctx: context).nextPage(
                                page: const CoachBookingDetailsScreen());
                          },
                          "Monday, 28 Jun, 2022",
                          "From 8:00AM to 3:00PM",
                          "Fitness",
                          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr.",
                          AppImages.diaryPic1,
                        ),
                        const SizedBox(height: 10),
                        _buildEventContainer(
                          onPress: () {
                            PageNavigator(ctx: context).nextPage(
                                page: const CoachBookingDetailsScreen());
                          },
                          "Monday, 28 Jun, 2022",
                          "From 8:00AM to 3:00PM",
                          "Yoga",
                          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr.",
                          AppImages.diaryPic2,
                        ),
                      ],
                    ),
                  )
                : const SizedBox
                    .shrink(),*/ // Return nothing when no date is selected
            _isDateSelected
                ? _loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _buildEventContainer(
                      onPress: () {
                        PageNavigator(ctx: context).nextPage(
                            page: const CoachBookingDetailsScreen());
                      },
                      DateFormat('EEEE, dd MMM, yyyy').format(event.date),
                      event.time,
                      event.title,
                      event.description,
                      event.image,
                    ),
                  );
                },
              ),
            )
                : const SizedBox.shrink(),

          ],
        ),
      ),
    );
  }

  // Event Container Widget
  Widget _buildEventContainer(String date, String time, String title,
      String description, String imageUrl,
      {required VoidCallback onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SvgPicture.asset(
                imageUrl,
                // height: 60,
                // width: 60,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(width: 15),

            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: date,
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: time,
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    text: title,
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    text: description,
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DiaryEvent> _events = [];
  bool _loading = false;

  Future<void> _loadEvents(DateTime date) async {
    setState(() {
      _loading = true;
    });
    try {
      _events = await DiaryService.fetchEventsForDate(date);
      print('events $_events');
      _isDateSelected = true;
    } catch (e) {
      print('Erreur : $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

}

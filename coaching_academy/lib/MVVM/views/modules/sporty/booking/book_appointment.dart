import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/bank_details/bank_details.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/bank_details/bank_details_main_screen.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  int selectedTimeIndex = -1;
  String selectedGender = 'Male';
  String selectedTrainingPlace = 'Indoor';
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Book Appointment",
          onPress: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              // Calendar Section
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // Set background color to white
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // Update the focused day as well
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle:
                        TextStyle(color: Colors.black, fontSize: 16),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.black),
                  ),
                  calendarFormat: CalendarFormat.month,
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.black),
                    weekendStyle: TextStyle(color: Colors.black),
                  ),
                  availableGestures: AvailableGestures.all,
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      if (day.weekday == DateTime.sunday) {
                        return const Center(
                          child: CustomText(
                            text: 'Sun',
                            isPoppins: true,
                            color: Colors.red,
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Select available time section
                    const CustomText(
                      text: 'Select available time',
                      color: Colors.white,
                      fontSize: 16,
                      isPoppins: true,
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        List<String> times = [
                          '07:00',
                          '08:00',
                          '09:00',
                          '11:00',
                          '12:00',
                          '01:00',
                          '02:00',
                          '04:00'
                        ];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTimeIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedTimeIndex == index
                                  ? AppColors.primaryGreen
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: CustomText(
                                text: times[index],
                                color: Colors.black,
                                isPoppins: true,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Select Gender Section
                    const CustomText(
                      text: 'Select Gender',
                      color: Colors.white,
                      fontSize: 16,
                      isPoppins: true,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildRadioButton('Male', selectedGender),
                          _buildRadioButton('Female', selectedGender),
                          _buildRadioButton('Other', selectedGender),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Select Training Place Section
                    const CustomText(
                      text: 'Training Place',
                      color: Colors.white,
                      fontSize: 16,
                      isPoppins: true,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTrainingPlaceButton(
                                  'Indoor', selectedTrainingPlace),
                              _buildTrainingPlaceButton(
                                  'out door', selectedTrainingPlace),
                              _buildTrainingPlaceButton(
                                  'Home', selectedTrainingPlace),
                            ],
                          ),
                        ),
                        _buildTrainingPlaceButton('Gym', selectedTrainingPlace),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              // Continue Button
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.5, 50),
                        backgroundColor: Colors.white),
                    onPressed: () {
                      PageNavigator(ctx: context).nextPage(
                          page: BankDetailsPage(
                        onSavePress: () {
                          PageNavigator(ctx: context).nextPage(
                              page: BankDetailsMainScreen(
                            onAddPress: () {
                              PageNavigator(ctx: context).nextPage(
                                  page: BankDetailsPage(
                                onSavePress: () {
                                  Navigator.pop(context);
                                },
                              ));
                            },
                          ));
                        },
                      ));
                    },
                    child: const CustomText(
                      text: "Continue",
                      color: Colors.black,
                    )),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton(String label, String groupValue) {
    return Row(
      children: [
        Radio<String>(
          activeColor: Colors.green,
          value: label,
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value!;
            });
          },
        ),
        CustomText(
          text: label,
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _buildTrainingPlaceButton(String label, String groupValue) {
    return Row(
      children: [
        Radio<String>(
          activeColor: Colors.green,
          value: label,
          groupValue: selectedTrainingPlace,
          onChanged: (value) {
            setState(() {
              selectedTrainingPlace = value!;
            });
          },
        ),
        CustomText(
          text: label,
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

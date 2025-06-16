import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/booking/book_appointment.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  int? _selectedTileIndex; // To track which tile is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Booking",
          onPress: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              buildNewBookingTile(0, 'Service Name 1', '45 Min', '\$30'),
              buildNewBookingTile(1, 'Service Name 2', '45 Min', '\$30'),
              buildNewBookingTile(2, 'Service Name 3', '45 Min', '\$30'),
              buildNewBookingTile(3, 'Service Name 4', '45 Min', '\$30'),
              buildNewBookingTile(4, 'Service Name 5', '45 Min', '\$30'),
              buildNewBookingTile(5, 'Service Name 6', '45 Min', '\$30'),
              buildNewBookingTile(6, 'Service Name 7', '45 Min', '\$30'),
              20.verticalSpace,
              ElevatedButton(
                onPressed: _selectedTileIndex == null
                    ? () {}
                    : () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const BookAppointment());
                      },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                  backgroundColor: _selectedTileIndex == null
                      ? const Color(0xffA0A0A0)
                      : Colors.white,
                ),
                child: CustomText(
                  color:
                      _selectedTileIndex == null ? Colors.white : Colors.black,
                  text: "Continue",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated buildNewBookingTile to accept an index and manage selection
  Widget buildNewBookingTile(
      int index, String title, String duration, String price) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTileIndex = index; // Set selected tile
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _selectedTileIndex == index
                ? AppColors.primaryGreen // Green border for selected tile
                : Colors.transparent, // No border for unselected tile
            width: 2, // Border width
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  isPoppins: true,
                ),
                CustomText(
                  text: duration,
                  color: Colors.black,
                  isPoppins: true,
                ),
              ],
            ),
            CustomText(
              text: price,
              color: Colors.black,
              isPoppins: true,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

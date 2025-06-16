import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({super.key});

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Reason & Suggest",
          onPress: () {
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              controller: reasonController,
              hintText: "Reason",
              maxLines: 5,
            ),
            20.verticalSpace,
            Row(
              // mainAxisAlignment: MainAxisAlignment
              //     .spaceEvenly, // Optional: Aligns text fields to the edges
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: const CustomText(
                          text: "Suggest Date",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          isPoppins: true,
                        ),
                      ), // Label for date
                      20.verticalSpace,
                      CustomTextField(
                        controller: dateController,
                        hintText: '12-01-2020',
                        // Add any other necessary parameters
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // Space between the two text fields
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: const CustomText(
                          text: "Preferred Time",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          isPoppins: true,
                        ),
                      ), // Label for time
                      20.verticalSpace,

                      CustomTextField(
                        controller: timeController,
                        hintText: '11:00 AM',
                        // Add any other necessary parameters
                      ),
                    ],
                  ),
                ),
              ],
            ),
            100.verticalSpace,
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(150, 40)),
              child: const CustomText(
                text: "Send",
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                isPoppins: true,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  // backgroundColor: Colors.white
                  ),
              child: const CustomText(
                text: "Skip",
                fontSize: 18,
                fontWeight: FontWeight.w400,
                isPoppins: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';

class CoachNotifications extends StatefulWidget {
  const CoachNotifications({super.key});

  @override
  State<CoachNotifications> createState() => _CoachNotificationsState();
}

class _CoachNotificationsState extends State<CoachNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutLeading(title: "Notifications"),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CoachNotificationWidget(),
            CoachNotificationWidget(),
            CoachNotificationWidget(),
            CoachNotificationWidget(),
            CoachNotificationWidget(),
          ],
        ),
      ),
    );
  }
}

class CoachNotificationWidget extends StatelessWidget {
  const CoachNotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit.",
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GreyCustomText(
                text: "12:00 AM",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              )
            ],
          )
        ],
      ),
    );
  }
}

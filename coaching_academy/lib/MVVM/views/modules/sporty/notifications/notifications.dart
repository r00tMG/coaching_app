import 'package:coaching_academy/MVVM/views/modules/sporty/notifications/widgets/notification_item.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const CustomText(
            text: 'Notification',
            color: Colors.white,
            isPoppins: true,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bottom: TabBar(
            dividerColor: Colors.white.withOpacity(0.2),
            labelStyle: GoogleFonts.poppins(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Read'),
              Tab(text: 'Unread'),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              AppImages.backArrow2,
              color: Colors.white,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Read Notifications Tab
            ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                NotificationItem(
                  title: 'Reminder',
                  description:
                      'You have a therapy session scheduled for tomorrow at 3 PM with dr Alexander.',
                  time: '12:00 AM',
                  isRead: true,
                ),
                NotificationItem(
                  title: 'New Resource Available',
                  description:
                      'Check out the latest article on stress management in your resources section.',
                  time: '12:00 AM',
                  isRead: true,
                ),
              ],
            ),

            // Unread Notifications Tab
            ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                NotificationItem(
                  title: 'Reminder',
                  description:
                      'You have a therapy session scheduled for tomorrow at 3 PM with dr Alexander.',
                  time: '12:00 AM',
                  isRead: false,
                ),
                NotificationItem(
                  title: 'New Resource Available',
                  description:
                      'Check out the latest article on stress management in your resources section.',
                  time: '12:00 AM',
                  isRead: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

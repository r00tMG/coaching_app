import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/message_details.dart';
import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';

import '../../../../models/NotificationModel.dart';

class CoachNotifications extends StatefulWidget {
  const CoachNotifications({super.key});

  @override
  State<CoachNotifications> createState() => _CoachNotificationsState();
}

class _CoachNotificationsState extends State<CoachNotifications> {
  late Future<List<NotificationModel>> futureNotifications;

  @override
  void initState() {
    super.initState();
    futureNotifications = fetchCoachNotifications();
  }

  Future<List<NotificationModel>> fetchCoachNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('http://localhost:8000/api/notifications'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      print("response api/notifications: $list");
      return list.map((item) => NotificationModel.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors du chargement des notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutLeading(title: "Notifications"),
      body: FutureBuilder<List<NotificationModel>>(
        future: futureNotifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune notification."));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              //print("notif: ${notif.time}");
              return CoachNotificationWidget(
                title: notif.title,
                description: notif.description,
                time: notif.time,
                senderId: notif.senderId ?? 0,
                senderName: notif.senderName ?? "",
                senderImage: notif.senderImage ?? "",
              );
            },
          );
        },
      ),
    );
  }
}

class CoachNotificationWidget extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final int senderId;
  final String senderName;
  final String senderImage;

  const CoachNotificationWidget({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.senderId,
    required this.senderName,
    required this.senderImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Ouvre la conversation avec le sender
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MessageDetails(
              username: senderName,
              userImage: senderImage,
              receiverId: senderId,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "$title\n$description",
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GreyCustomText(
                  text: time,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

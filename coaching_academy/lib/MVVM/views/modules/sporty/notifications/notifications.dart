import 'dart:convert';

import 'package:coaching_academy/MVVM/views/modules/sporty/notifications/widgets/notification_item.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/NotificationModel.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  void _refresh() {
    setState(() {});
  }

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
            FutureBuilder(
              future: fetchNotifications(true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Aucune notification lue."));
                }
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: snapshot.data!.map((notif) {
                    return NotificationItem(
                      id: notif.id,
                      title: notif.title,
                      description: notif.description,
                      time: notif.time,
                      isRead: notif.isRead,
                      onRefresh: _refresh,
                    );
                  }).toList(),
                );
              },
            ),
            FutureBuilder(
              future: fetchNotifications(false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Aucune notification non lue."));
                }
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: snapshot.data!.map((notif) {
                    return NotificationItem(
                      id: notif.id,
                      title: notif.title,
                      description: notif.description,
                      time: notif.time,
                      isRead: notif.isRead,
                      onRefresh: _refresh,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<NotificationModel>> fetchNotifications(bool read) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse("http://localhost:8000/api/notifications"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      return list
          .map((item) => NotificationModel.fromJson(item))
          .where((n) => n.isRead == read)
          .toList();
    } else {
      throw Exception("Erreur de chargement des notifications");
    }
  }
}


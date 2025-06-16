import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../models/CoachUser.dart';
import '../message_details.dart';
class CoachListModal extends StatefulWidget {
  @override
  _CoachListModalState createState() => _CoachListModalState();
}

class _CoachListModalState extends State<CoachListModal> {
  List<dynamic> coaches = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCoaches();
  }

  Future<void> fetchCoaches() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse("http://localhost:8000/api/coach/services"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final services = data['services'];

      // Pour supprimer les doublons
      final Set<int> seenUserIds = {};
      final List<dynamic> uniqueCoaches = [];

      for (var service in services) {
        final user = service['user'];
        if (user != null && !seenUserIds.contains(user['id'])) {
          seenUserIds.add(user['id']);
          uniqueCoaches.add(service);
        }
      }

      setState(() {
        coaches = uniqueCoaches;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Gère les erreurs ici
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.75,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: coaches.length,
        itemBuilder: (context, index) {
          final coach = coaches[index]['user'];
          if (coach == null) return SizedBox(); // skip null user

          final String name = coach['name'];
          final String imageUrl =
              "http://localhost:8000/storage/${coach['profile_picture']}";
          final int receiverId = coach['id'];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(name),
            onTap: () {
              Navigator.pop(context); // Ferme le modal
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageDetails(
                    username: name,
                    userImage: imageUrl,
                    receiverId: receiverId,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

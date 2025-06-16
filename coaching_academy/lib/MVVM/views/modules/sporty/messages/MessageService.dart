import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/CoachUser.dart';

class MessageService {
  static Future<bool> sendMessage({
    required int receiverId,
    required String content,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Token de connexion

    final response = await http.post(
      Uri.parse('http://localhost:8000/api/messages/send'), // Remplace par ton IP locale ou domaine
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'receiver_id': receiverId,
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['status'] == true;
    } else {
      print("Erreur d'envoi: ${response.body}");
      return false;
    }
  }


}

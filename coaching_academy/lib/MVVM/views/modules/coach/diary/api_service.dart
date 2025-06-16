import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../models/DiaryEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryService {
  static Future<List<DiaryEvent>> fetchEventsForDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('token dans service details $token');
    final formattedDate = date.toIso8601String().split('T').first;
    //final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print('format date: $formattedDate');
    final url = Uri.parse('http://0.0.0.0:8000/api/events?date=$formattedDate');

    final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('response api service: $response');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print("data of api : $data");
      return data.map((json) => DiaryEvent.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des événements');
    }
  }
}

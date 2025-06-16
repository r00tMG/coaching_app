import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../models/BookingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  static Future<List<BookingModel>> fetchBookings({required int status}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      print('token dans booking service $token');
      final response = await http.get(Uri.parse('http://0.0.0.0:8000/api/bookings?status=$status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('data: $data');
        return data.map((e) => BookingModel.fromJson(e)).toList();
      } else {
        throw Exception('Erreur ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}

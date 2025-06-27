import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../models/DiaryEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryService {

  static List<DiaryEvent> parseEventsFromServices(List<dynamic> servicesJson) {
    List<DiaryEvent> events = [];

    for (final serviceJson in servicesJson) {
      final createdAt = DateTime.parse(serviceJson['created_at']);
      final workingHours = serviceJson['working_hours'] as List<dynamic>? ?? [];
      final workspaceMedias = serviceJson['workspace_medias'] as List<dynamic>? ?? [];
      final imageUrl = workspaceMedias.isNotEmpty
          ? workspaceMedias[0]['workspace_image'] ?? 'assets/default_image.svg'
          : 'assets/default_image.svg';

      for (final wh in workingHours) {
        final startHour = wh['start_hour'] ?? '';
        final endHour = wh['end_hour'] ?? '';
        final timeRange = '$startHour - $endHour';

        final event = DiaryEvent(
          id: '${serviceJson['id']}_${wh['id']}', // id unique par working hour
          title: serviceJson['service_name'] ?? '',
          description: serviceJson['description'] ?? '',
          date: DateTime(createdAt.year, createdAt.month, createdAt.day),
          time: timeRange,
          image: imageUrl,
        );
        events.add(event);
      }
    }

    return events;
  }


  static Future<List<DiaryEvent>> fetchAllEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('http://0.0.0.0:8000/api/coach/services'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      final List<dynamic> data = decoded is List
          ? decoded
          : decoded['services']; // ou autre clé selon ta réponse API

      return parseEventsFromServices(data);
    } else {
      throw Exception('Erreur lors du chargement des services');
    }
  }

  static Future<List<DiaryEvent>> fetchEventsForDate(DateTime date) async {
    // Filtrage local dans Flutter (plus simple si pas dispo côté API)
    final allEvents = await fetchAllEvents();
    return allEvents.where((event) =>
    event.date.year == date.year &&
        event.date.month == date.month &&
        event.date.day == date.day
    ).toList();
  }
}

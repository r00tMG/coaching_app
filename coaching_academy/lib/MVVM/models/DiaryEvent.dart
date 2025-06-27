class DiaryEvent {
  final String id;
  final String title;
  final String description;
  final DateTime date;  // on prendra created_at date ou un jour précis (voir remarque ci-dessous)
  final String time;    // start - end horaires concaténés
  final String image;   // workspace image ou un placeholder

  DiaryEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.image,
  });

  factory DiaryEvent.fromServiceJson(Map<String, dynamic> json) {
    // Prendre la date du service (created_at) - peut être adapté selon besoin réel
    final createdAt = DateTime.parse(json['created_at']);

    // Si plusieurs working_hours, on crée plusieurs events (voir plus bas),
    // ici on récupère le premier working_hour pour l'exemple simple :
    final workingHours = json['working_hours'] as List<dynamic>? ?? [];

    // Pour simplifier ici, on prendra juste le premier working_hour
    final wh = workingHours.isNotEmpty ? workingHours[0] : null;
    String timeRange = '';
    if (wh != null) {
      timeRange = '${wh['start_hour']} - ${wh['end_hour']}';
    }

    // Image workspace (première image)
    final workspaceMedias = json['workspace_medias'] as List<dynamic>? ?? [];
    String imageUrl = workspaceMedias.isNotEmpty
        ? workspaceMedias[0]['workspace_image'] ?? 'assets/default_image.svg'
        : 'assets/default_image.svg';

    return DiaryEvent(
      id: json['id'].toString(),
      title: json['service_name'] ?? '',
      description: json['description'] ?? '',
      date: DateTime(createdAt.year, createdAt.month, createdAt.day), // sans heure
      time: timeRange,
      image: imageUrl,
    );
  }
}

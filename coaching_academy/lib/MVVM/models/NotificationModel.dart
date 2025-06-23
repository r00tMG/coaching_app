class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final int? senderId; // ← ajoute ceci
  final String? senderName;
  final String? senderImage;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    this.senderId,
    this.senderName,
    this.senderImage,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final rawDate = DateTime.parse(json['created_at']).toLocal();
    final formatted = formatDateTime(rawDate);

    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: formatted,
      isRead: json['is_read'] == 1,
      senderId: json['sender_id'],
      senderName: json['sender_name'],
      senderImage: json['sender_image'],
    );
  }

  static String formatDateTime(DateTime dateTime) {
    final jours = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche'];
    final mois = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    final jourSemaine = jours[dateTime.weekday - 1];
    final moisTexte = mois[dateTime.month - 1];
    return '$jourSemaine, ${dateTime.day.toString().padLeft(2, '0')} $moisTexte ${dateTime.year} à ${dateTime.hour}h${dateTime.minute.toString().padLeft(2, '0')}min';
  }
}

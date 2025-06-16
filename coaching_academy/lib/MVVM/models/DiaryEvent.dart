class DiaryEvent {
  final String date;
  final String time;
  final String title;
  final String description;
  final String image;

  DiaryEvent({
    required this.date,
    required this.time,
    required this.title,
    required this.description,
    required this.image,
  });

  factory DiaryEvent.fromJson(Map<String, dynamic> json) {
    return DiaryEvent(
      date: json['date'],
      time: json['time'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}

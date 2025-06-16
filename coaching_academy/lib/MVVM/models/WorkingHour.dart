class WorkingHour {
  final String startHour;
  final String endHour;
  final String trainingOption;

  WorkingHour({
    required this.startHour,
    required this.endHour,
    required this.trainingOption,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) {
    return WorkingHour(
      startHour: json['start_hour'],
      endHour: json['end_hour'],
      trainingOption: json['training_option'],
    );
  }
}

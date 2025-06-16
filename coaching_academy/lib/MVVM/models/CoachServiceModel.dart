class CoachServiceModel {
  final int id;
  final int serviceId;
  final String name;
  final String duration;
  final String price;

  CoachServiceModel({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.duration,
    required this.price,
  });

  factory CoachServiceModel.fromJson(Map<String, dynamic> json) {
    return CoachServiceModel(
      id: json['id'],
      serviceId: json['service_id'],
      name: json['name'],
      duration: json['duration'],
      price: json['price'],
    );
  }
}

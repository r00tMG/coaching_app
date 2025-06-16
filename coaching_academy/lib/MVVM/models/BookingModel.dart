class BookingModel {
  final String id;
  final String userName;
  final String serviceName;
  final String price;
  final int status;
  final String date;

  BookingModel({
    required this.id,
    required this.userName,
    required this.serviceName,
    required this.price,
    required this.status,
    required this.date,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'].toString(),
      userName: json['user_name'] ?? '',
      serviceName: json['service_name'] ?? '',
      price: json['price'].toString(),
      status: json['status'],
      date: json['date'] ?? '',
    );
  }
}

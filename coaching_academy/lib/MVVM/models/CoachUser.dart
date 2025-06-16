class CoachUser {
  final int id;
  final String name;
  final String? profilePicture;

  CoachUser({required this.id, required this.name, this.profilePicture});

  factory CoachUser.fromJson(Map<String, dynamic> json) {
    return CoachUser(
      id: json['user']['id'],
      name: json['user']['name'],
      profilePicture: json['user']['profile_picture'],
    );
  }
}

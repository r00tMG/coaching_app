class UserModel {
  final int id;
  final String name;
  final String email;
  final String? role;
  final String? location;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? workspaceMedia;
  final String? workspaceVideo;
  final String? profilePicture;
  final String? bio;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.location,
    this.address,
    this.latitude,
    this.longitude,
    this.workspaceMedia,
    this.workspaceVideo,
    this.profilePicture,
    this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      location: json['location'],
      address: json['address'],
      latitude: parseDouble(json['latitude']),
      longitude: parseDouble(json['longitude']),
      workspaceMedia: json['workspace_media'],
      workspaceVideo: json['workspace_video'],
      profilePicture: json['profile_picture'],
      bio: json['bio'],
    );
  }

}

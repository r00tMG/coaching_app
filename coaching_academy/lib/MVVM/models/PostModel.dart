class PostModel {
  final int id;
  final String userName;
  final String? topicName;
  final String? content;
  final String? imagePath;
  final String createdAt;
  final int likesCount;
  final int commentsCount;

  PostModel({
    required this.id,
    required this.userName,
    this.topicName,
    this.content,
    this.imagePath,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userName: json['user_name'],
      topicName: json['topic_name'],
      content: json['content'],
      createdAt: json['created_at'],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      imagePath: json['image_path'],
    );
  }
}

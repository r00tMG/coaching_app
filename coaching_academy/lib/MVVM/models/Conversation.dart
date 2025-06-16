class Conversation {
  final int receiverId;
  final String username;
  final String userImage;
  final String lastMessage;
  final String lastTime;

  Conversation({
    required this.receiverId,
    required this.username,
    required this.userImage,
    required this.lastMessage,
    required this.lastTime,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      receiverId: json['receiver_id'],
      username: json['username'],
      userImage: json['user_image'],
      lastMessage: json['last_message'],
      lastTime: json['last_time'],
    );
  }
}

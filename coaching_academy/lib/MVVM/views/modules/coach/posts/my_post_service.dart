import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/PostModel.dart';

Future<List<PostModel>> fetchMyPosts() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  final response = await http.get(Uri.parse('http://0.0.0.0:8000/api/my_posts'),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  });
  //print("")
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List posts = data['posts'];
    print("Liste des posts: $posts");
    return posts.map((json) => PostModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

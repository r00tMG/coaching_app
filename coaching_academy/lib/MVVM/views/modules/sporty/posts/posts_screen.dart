import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/posts/widget/posts_widget.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../models/PostModel.dart';
import '../../coach/posts/post_service.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});
  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late Future<List<PostModel>> futurePosts;

  String userName = 'anonymous_user';
  String content = 'Aucun contenu pour le moment.';
  String topicName = 'Général';
  String createdAt = DateTime.now().toIso8601String(); // ou une date formatée
  int likesCount = 0;
  int commentsCount = 0;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
    print("post: ${futurePosts}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutLeading(title: "Posts"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<PostModel>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Aucun post disponible.');
                }

                final posts = snapshot.data!;
                return Column(
                  children: posts.map((post) {
                    return PostsWidget(
                      userName: post.userName,
                      description: post.content ?? '',
                      bottomDescription: post.topicName ?? '',
                      date: post.createdAt,
                      imageUrl: post.imagePath?.replaceFirst('http://0.0.0.0', 'http://127.0.0.1'),
                      likesCount: post.likesCount.toString(),
                      commentCount: post.commentsCount.toString(),
                    );
                  }).toList(),
                );
              },
            ),
            20.verticalSpace,

          ],
        ),
      ),
    );
  }
}

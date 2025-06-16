import 'package:coaching_academy/MVVM/views/modules/coach/posts/post_service.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/posts/widget/posts_widget.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/PostModel.dart';
import 'my_post_service.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({super.key});

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

/*
class _MyPostsScreenState extends State<MyPostsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
            fillColor: AppColors.backgroundGrey,
            controller: searchController,
            borderColor: Colors.transparent,
            textColor: Colors.white,
            iconColor: Colors.white,
            hintTextColor: Colors.white,
            borderRadius: 10,
            hintText: "What's in your mind",
            hintStyle: GoogleFonts.abel(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
            style: GoogleFonts.abel(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
            iconPath: AppImages.searchIcon,
          ),
          20.verticalSpace,
          const PostsWidget(
            bottomDescription:
                "Human art Lorem ipsum dolo amet, consectetur ...more",
            commentCount: "12",
            date: "Apr 24 at10:23 AM",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare accumsan sem.",
            likesCount: "100",
            userName: "romanempire0987",
          ),
          20.verticalSpace,
          const PostsWidget(
            bottomDescription:
                "Human art Lorem ipsum dolo amet, consectetur ...more",
            commentCount: "12",
            date: "Apr 24 at10:23 AM",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare accumsan sem.",
            likesCount: "100",
            userName: "romanempire0987",
          ),
        ],
      ),
    );
  }
}
*/

class _MyPostsScreenState extends State<MyPostsScreen> {
  TextEditingController searchController = TextEditingController();
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
    futurePosts = fetchMyPosts();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: Text("My Posts"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              fillColor: AppColors.backgroundGrey,
              controller: searchController,
              borderColor: Colors.transparent,
              textColor: Colors.white,
              iconColor: Colors.white,
              hintTextColor: Colors.white,
              borderRadius: 10,
              hintText: "What's in your mind",
              hintStyle: GoogleFonts.abel(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              style: GoogleFonts.abel(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              iconPath: AppImages.searchIcon,
            ),
            20.verticalSpace,
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
          ],
        ),
      ),
    );
  }

}

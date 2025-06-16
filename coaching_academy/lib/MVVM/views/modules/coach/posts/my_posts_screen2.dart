import 'package:coaching_academy/MVVM/views/modules/sporty/posts/widget/posts_widget.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPostsScreen2 extends StatefulWidget {
  const MyPostsScreen2({super.key});

  @override
  State<MyPostsScreen2> createState() => _MyPostsScreen2State();
}

class _MyPostsScreen2State extends State<MyPostsScreen2> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    color: Colors.white),
                style: GoogleFonts.abel(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
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
        ),
      ),
    );
  }
}

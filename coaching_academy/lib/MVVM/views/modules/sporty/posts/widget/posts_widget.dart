import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PostsWidget extends StatelessWidget {
  final String userName;
  final String date;
  final String description;
  final String likesCount;
  final String commentCount;
  final String bottomDescription;
  final String? imageUrl;
  const PostsWidget({
    super.key,
    required this.description,
    required this.likesCount,
    required this.commentCount,
    required this.bottomDescription,
    required this.userName,
    required this.date,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: userName,
                style: GoogleFonts.abel(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.more_horiz,
                color: Colors.black,
              )
            ],
          ),
          CustomText(
            text: date,
            style: GoogleFonts.abel(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xff9e9e9e),
            ),
          ),
          20.verticalSpace,
          CustomText(
            text: description,
            style: GoogleFonts.abel(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          10.verticalSpace,
          //Center(child: SvgPicture.asset(AppImages.postImage)),
          Center(
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
              imageUrl!, // Utilise l'URL dynamique
              height: 200, // Définir la hauteur de l'image
              width: double.infinity,
              fit: BoxFit.cover, // Adapter l'image à la largeur
              //errorBuilder: (context, error, stackTrace) => SvgPicture.asset(AppImages.postImage), // Gérer l'erreur si l'image ne peut pas être chargée
                errorBuilder: (context, error, stackTrace) {
                  print("Erreur de chargement d'image: $error");
                  return SvgPicture.asset(AppImages.postImage); // Test avec une image publique
                }

            )
                : SvgPicture.asset(AppImages.postImage), // Afficher une icône d'erreur si aucune URL n'est fournie
          ),

          10.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      AppImages.likeIcon,
                    ),
                    10.verticalSpace,
                    CustomText(
                      text: "$likesCount Likes",
                      style: GoogleFonts.abel(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                20.horizontalSpace,
                Column(
                  children: [
                    SvgPicture.asset(
                      AppImages.commentIcon,
                    ),
                    10.verticalSpace,
                    CustomText(
                      text: "$commentCount Comments",
                      style: GoogleFonts.abel(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          5.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: CustomText(
              text: bottomDescription,
              style: GoogleFonts.abel(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

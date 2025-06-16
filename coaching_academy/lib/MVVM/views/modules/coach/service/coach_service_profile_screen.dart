import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/onboarding/service_details.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../models/ServiceCoachModel.dart';

class CoachServiceProfileScreen extends StatelessWidget {
  final ServiceCoachModel service;
  const CoachServiceProfileScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack for cover photo, profile image, and heart icon
              Stack(
                clipBehavior: Clip.none, // Allow overflow of the profile image
                children: [
                  Positioned(
                    child: Container(
                      // height: 200,
                      // width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          // image: DecorationImage(
                          //   image: NetworkImage(
                          //       'https://images.pexels.com/photos/1323206/pexels-photo-1323206.jpeg?cs=srgb&dl=pexels-mixu-513809-1323206.jpg&fm=jpg'),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                      child: Image.asset(
                        AppImages.coverPhoto,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ) ?? Image.network(
                        "http://0.0.0.0:8000/storage/${service.workspaceMedias.first.workspaceImage}",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        errorBuilder: (context, error, stackTrace) => Image.asset(AppImages.coverPhoto),
                      )
                      ,
                    ),
                  ),

                  // Cover Photo
                  Positioned(
                    top: 10,
                    left: 10,
                    right: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        // height: 200,
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, right: 10, bottom: 10),
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xffd3d3d3).withOpacity(0.2),
                            shape: BoxShape.circle
                            // image: DecorationImage(
                            //   image: NetworkImage(
                            //       'https://images.pexels.com/photos/1323206/pexels-photo-1323206.jpeg?cs=srgb&dl=pexels-mixu-513809-1323206.jpg&fm=jpg'),
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Profile Image (stacked in the middle, half over the cover photo and half below)
                  Positioned(
                    bottom: -80, // Half of the image will be on the main screen
                    left: 10, // Center the image
                    child: Container(
                      color: Colors.transparent,
                      height: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          service.user.profilePicture ?? AppImages.profilePicture,
                        )
                          //Image.asset(AppImages.profilePicture),
                      ),
                    ),
                  ),

                  // Heart Icon (stacked on top of the cover photo)

                  Positioned(
                    top: 245,
                    left: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: service.serviceName ?? 'Cameron Jones',
                          isPoppins: true,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            CustomText(
                              text: '4.5 (56)',
                              color: Colors.white70,
                              isPoppins: true,
                            ),
                          ],
                        ),
                        CustomText(
                          text: service.serviceName ?? 'Yoga Trainer',
                          color: Colors.white70,
                          isPoppins: true,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.white, size: 16),
                            CustomText(
                              text: service.user.address ?? '111 Street main Buleva...',
                              isPoppins: true,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height:
                      60), // To account for the overflow of the profile image

              // Trainer Info (below the profile image)
              // Stack(
              //   children: [
              //     Positioned(
              //         bottom: 0,
              //         right: 0,
              //         left: 0,
              //         top: -100,
              //         child: Container(
              //           height: 400,
              //           color: AppColors.backgroundGrey,
              //         )),
              //   ],
              // ),
              const SizedBox(height: 16),

              // Image Carousel Section
              Container(
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildImageCarouselItem(AppImages.pic1),
                    buildImageCarouselItem(AppImages.pic2),
                    buildImageCarouselItem(AppImages.pic4),
                    buildImageCarouselItem(AppImages.pic5),
                    // Add more images as needed
                  ],
                ),
              ),

              // Description Section
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: const CustomText(
                  isPoppins: true,
                  text: "Description",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  isPoppins: true,
                  text: service.description ??
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac feugiat quis faucibus dui diam. Vestibulum, elementum, pretium in suspendisse interdum aenean id sapien, amet. Quis varius lorem felis tortor cursus tempor.',
                  color: Colors.black,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Service List",
                      isPoppins: true,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    GreyCustomText(
                      text: "View all",
                      isPoppins: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              // Service List Section
              Container(
                padding: const EdgeInsets.all(16.0),
                child:
                /*Column(
                  children: [
                    buildServiceTile('Yoga Service', '45 Min', '\$30'),
                    buildServiceTile('Running Tips', '60 Min', '\$40'),
                    buildServiceTile('Circuit Training', '70 Min', '\$50'),
                    buildServiceTile('Fitness Training', '90 Min', '\$60'),
                    // Add more services as needed
                  ],
                )*/
                Column(
                  children: service.coachServices.map((hour) {
                    return buildServiceTile(
                      hour.name ?? 'Nom',
                      '${hour.duration}' ?? '1',
                      '\$${hour.price}' '1',
                    );
                  }).toList(),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const ServiceDetailsScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.editProfileIcon,
                        color: Colors.black,
                      ),
                      5.horizontalSpace,
                      const CustomText(
                        text: "Edit",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              SvgPicture.asset(AppImages.mapPinned),

              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  final String imagePath;
  final String date;
  final String description;
  const ReviewSection({
    super.key,
    required this.imagePath,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(imagePath),
          Row(
            children: [
              for (int i = 0; i < 5; i++) ...[
                const Icon(Icons.star, color: Colors.yellow, size: 16)
              ],
              CustomText(
                text: date,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                isPoppins: true,
              )
            ],
          ),
          CustomText(
            text: description,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            isPoppins: true,
          )
        ],
      ),
    );
  }
}

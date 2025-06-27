import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/booking/new_booking.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/no_message_screen.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../models/ServiceCoachModel.dart';

class SportyServiceProfileScreen extends StatelessWidget {
  final ServiceCoachModel service;

  const SportyServiceProfileScreen({required this.service, super.key});


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
                      child:
                        Image.network(
                      //service.user.profilePicture ??
                          'https://via.placeholder.com/150',
                        height: 160,
                        width: 160,
                        fit: BoxFit.cover,
                      )


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
                    bottom: -87, // Half of the image will be on the main screen
                    left: 10, // Center the image
                    child: Container(
                      color: Colors.transparent,
                      height: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:Image.network(
                          //service.user.profilePicture ??
                              'https://via.placeholder.com/600x200',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        ),
                      ),
                    ),
                  ),

                  // Heart Icon (stacked on top of the cover photo)
                  Positioned(
                    bottom: -20, // Half of the image will be on the main screen
                    right: 10,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 255,
                    left: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: service.user.name,
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
                        const CustomText(
                          text: 'Yoga Trainer',
                          color: Colors.white70,
                          isPoppins: true,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.white, size: 14),
                            CustomText(
                              text: service.user.location ?? '111 Street main Buleva...',
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
              //         top: -100,`1`
              //         child: Container(
              //           height: 400,
              //           color: AppColors.backgroundGrey,
              //         )),
              //   ],
              // ),
              const SizedBox(height: 20),

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
                  text: service.description ?? "No description provided",
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
                child: Column(
                  children: service.coachServices.map((s) {
                    return buildServiceTile(
                      s.name,
                      "${s.duration} Min",
                      "${s.price} \$",
                    );
                  }).toList(),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.4, 50),
                        backgroundColor: Colors.white),
                    onPressed: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const NoMessageScreen());
                    },
                    child: const CustomText(
                      text: "Message",
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.4, 50),
                        backgroundColor: Colors.white),
                    onPressed: () {
                      PageNavigator(ctx: context).nextPage(
                        page: NewBookingScreen(coachServices: service.coachServices),
                      );
                    },

                    child: const CustomText(
                      text: "Book Now",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              SvgPicture.asset(AppImages.mapPinned),
              10.verticalSpace,
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const CustomText(
                      isPoppins: true,
                      text: "Reviews",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const CustomText(
                      isPoppins: true,
                      text: "4.9 (23)",
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const ReviewSection(
                date: "12/3/21",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla orci vel neque, felis vitae lobortis. Nullam pharetra id vulputate diam morbi. Nibh odio scelerisque nunc, eget rutrum convallis.",
                imagePath: AppImages.avatar6,
              ),
              const ReviewSection(
                date: "12/3/21",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla orci vel neque, felis vitae lobortis. Nullam pharetra id vulputate diam morbi. Nibh odio scelerisque nunc, eget rutrum convallis.",
                imagePath: AppImages.avatar7,
              ),
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

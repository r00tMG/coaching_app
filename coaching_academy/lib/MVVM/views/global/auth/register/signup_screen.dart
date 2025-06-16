import 'dart:io';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/global/auth/login/login_screen.dart';
import 'package:coaching_academy/MVVM/views/global/auth/register/signup_step2.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/button/custom_button.dart';
import 'package:coaching_academy/utils/widgets/button/custom_outline_button.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Uint8List? _webImageBytes;
  XFile? _imageFile;

  Future getImageFromGallery() async {
    print("########### INSIDE FUNCTION ##########");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        setState(() {
          _webImageBytes = bytes;
          _imageFile = image;
        });
      } else {
        setState(() {
          _imageFile = image;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithArrow(context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 30.verticalSpace,
            // topHeader(context),
            50.verticalSpace,
            const CustomText(
              text: "Register for Wellness👋",
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: const GreyCustomText(
                text:
                    "Create your account to access personalized therapy and wellness resources.",
                textAlign: TextAlign.center,
              ),
            ),
            filterHeading("Your Name"),
            10.verticalSpace,
            CustomTextField(
                iconPath: AppImages.userIcon,
                controller: nameController,
                hintText: "Enter your name"),
            20.verticalSpace,
            filterHeading("Email or Phone Number"),
            10.verticalSpace,
            CustomTextField(
              iconPath: AppImages.emailIcon,
              controller: emailController,
              hintText: "Enter your email address",
            ),
            20.verticalSpace,
            filterHeading("Your Country"),
            10.verticalSpace,
            CustomTextField(
              iconPath: AppImages.countryIcon,
              isIconColor: false,
              controller: countryController,
              hintText: "Enter your country",
            ),
            20.verticalSpace,
            filterHeading("Your Address"),
            10.verticalSpace,
            CustomTextField(
              iconPath: AppImages.addressIcon,
              controller: addressController,
              hintText: "Enter your address",
            ),
            20.verticalSpace,
            filterHeading("Profile Picture"),
            10.verticalSpace,
            /*GestureDetector(
              onTap: getImageFromGallery,
              child: _image == null
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child:
                                SvgPicture.asset(AppImages.profilePictureIcon),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: const GreyCustomText(
                              text: "Attach Your Profile Picture",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.file(
                            File(_image!.path),
                            height: 100,
                          ),
                        ],
                      ),
                    ),
            )*/
            GestureDetector(
              onTap: pickProfileImage,
              child: _imageFile == null
                  ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: SvgPicture.asset(AppImages.profilePictureIcon),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const GreyCustomText(
                        text: "Attach Your Profile Picture",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
                  : Container(
                padding: const EdgeInsets.only(left: 20),
                child: kIsWeb
                    ? Image.memory(_webImageBytes!, height: 100)
                    : Image.file(File(_imageFile!.path), height: 100),
              ),
            ),
            // GestureDetector(
            //   onTap: getImageFromGallery,
            //   child: CustomTextField(
            //     iconPath: AppImages.profilePictureIcon,
            //     isIconColor: false,
            //     controller: countryController,
            //     hintText: "Attach your profile picture",
            //     // readOnly: true,
            //   ),
            // ),
            50.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  buttonText: "Continue",
                  /*onPressed: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const SignupScreenStep2());
                  }*/
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        countryController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        _imageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    bool success = await AuthService.signupUser(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      country: countryController.text.trim(),
                      address: addressController.text.trim(),
                      profileImage: kIsWeb
                          ? _webImageBytes
                          : File(_imageFile!.path),
                    );

                    if (success) {
                      PageNavigator(ctx: context).nextPage(page: const SignupScreenStep2());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Signup failed. Try again.")),
                      );
                    }
                  }

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 100, child: Divider()),
                5.horizontalSpace,
                const GreyCustomText(
                  text: "Have an account?",
                ),
                5.horizontalSpace,
                const SizedBox(width: 100, child: Divider()),
              ],
            ),
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutlineButton(
                buttonText: "Signin",
                onPressed: () {
                  PageNavigator(ctx: context)
                      .nextPage(page: const LoginScreen());
                },
              ),
            ),
            20.verticalSpace,
            SvgPicture.asset(AppImages.bottomMiddleRoundRing)
          ],
        ),
      ),
    );
  }
}

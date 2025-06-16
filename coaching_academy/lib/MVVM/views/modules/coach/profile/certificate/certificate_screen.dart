import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Future getImageFromGallery() async {
    print("########### INSIDE FUNCTION ##########");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Diplomas / Certification",
        onPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const CustomText(
                text: "Upload and verify ",
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
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
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.profileContactUs,
                            fit: BoxFit.scaleDown,
                            color: Colors.black,
                            height: 20,
                          ),
                          2.horizontalSpace,
                          const CustomText(
                            text: "Certifications",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: getImageFromGallery,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Row(
                          children: [
                            const CustomText(
                              text: "Upload now",
                            ),
                            5.horizontalSpace,
                            SvgPicture.asset(AppImages.uploadIcon)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const CustomText(
                    text: "Upload a photo of your\nCertifications",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

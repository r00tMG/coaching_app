import 'dart:ui';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/add_service_details/add_service_details.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShowOffWorkspaceScreen extends StatefulWidget {
  const ShowOffWorkspaceScreen({super.key});

  @override
  State<ShowOffWorkspaceScreen> createState() => _ShowOffWorkspaceScreenState();
}

class _ShowOffWorkspaceScreenState extends State<ShowOffWorkspaceScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? _video;
  /*Future getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }*/


// Pour choisir une image
  Future getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

// Pour choisir une vidéo
  Future getVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _video = video;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
          title: "Show Off Workspace",
          onPress: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Show off Your Workspace",
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              isPoppins: true,
            ),
            const SizedBox(height: 10),
            const CustomText(
              text:
                  "This photo will be displayed on your salon profile when clients look for you on All local things",
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              isPoppins: true,
            ),
            const SizedBox(height: 30),

            // Add Cover Photo
            _buildDottedPhotoBox(
              label: 'Add Cover photo',
              onTap: () => getImageFromCamera(),
              icon: const Icon(Icons.camera_alt, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Add Workspace Photo
            _buildDottedPhotoBox(
                label: 'Add Videos',
                onTap: () => getVideoFromGallery(),
                icon: SvgPicture.asset(
                  AppImages.videoIcon,
                )),

            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final success = await uploadMediaFiles();
                  if (success) {
                    PageNavigator(ctx: context).nextPage(page: const AddServiceDetailsScreen());
                  }
                },
                child: const CustomText(
                  text: "Continue",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  isPoppins: true,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Method to build the dotted photo box
  Widget _buildDottedPhotoBox(
      {required String label,
      required VoidCallback onTap,
      required Widget icon}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: CustomPaint(
          painter: DottedBorderPainter(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(height: 10),
                CustomText(
                  text: label,
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  isPoppins: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Pour uploader les deux
  Future<bool> uploadMediaFiles() async {
    if (_image == null || _video == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner une image et une vidéo")),
      );
      return false;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      print('token à la page show off workspace: $token');
      final uri = Uri.parse('http://0.0.0.0:8000/api/coach/workspace/upload');
      //print('Salut');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token';
      //print("salut encore");
      final imageBytes = await _image!.readAsBytes();
      final videoBytes = await _video!.readAsBytes();
      //print("salut encore 1");
      final imageFile = http.MultipartFile.fromBytes('image', imageBytes, filename: _image!.name);
      final videoFile = http.MultipartFile.fromBytes('video', videoBytes, filename: _video!.name);
      //print("salut encore 2");
      request.files.add(imageFile);
      request.files.add(videoFile);
      //print("salut encore 3");
      final response = await request.send();
      //print("salut encore 4");
      //print('response api : ${response.statusCode}');
      if (response.statusCode == 201) {
        final respStr = await response.stream.bytesToString();
        //print("Succès : $respStr");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fichiers uploadés avec succès")),
        );
        return true;
      } else {
        final error = await response.stream.bytesToString();
        print("Erreur : $error");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Échec de l’upload")),
        );
        return false;
      }
    } catch (e) {
      print("Erreur d’upload : $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur réseau")),
      );
      return false;
    }
  }






}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey // Color of the dotted border
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 6.0;
    const double dashSpace = 3.0;
    final Path path = Path();

    // Create a rounded rectangle path
    final RRect outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(10), // Roundness of the corners
    );

    // Convert the outerRect into a path
    final Path roundedRectPath = Path()..addRRect(outerRect);

    // Draw the dashed border along the rounded rectangle path
    final dashCount = (roundedRectPath.computeMetrics().first.length /
            (dashWidth + dashSpace))
        .floor();
    final PathMetrics metrics = roundedRectPath.computeMetrics();
    for (final PathMetric metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        path.addPath(
            metric.extractPath(distance, distance + dashWidth), Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

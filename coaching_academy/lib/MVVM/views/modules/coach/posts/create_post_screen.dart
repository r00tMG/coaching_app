import 'dart:io';
import 'package:coaching_academy/MVVM/views/modules/coach/posts/ask_now_screen.dart';
import 'package:coaching_academy/MVVM/views/modules/coach/posts/my_posts_screen.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/toast/custom_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String _selectedVisibility = "Public"; // Default value
  bool isUploaded = false;
  String? userName;
  String? userPhotoUrl;
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  TextEditingController _topicController = TextEditingController();
  TextEditingController _contentController = TextEditingController();


  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;
  Uint8List? _imageBytes;

  Future getImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _image = File(pickedFile.path);
      });
    }
  }


  Future getImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _image = File(pickedFile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isUploaded
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await createPost();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                child: CustomText(
                  text: "Upload",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText(
          text: isUploaded ? "My Posts" : "Create a post",
          style: GoogleFonts.abel(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            //Navigator.of(context).pop();
            createPost();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: isUploaded
          ? const MyPostsScreen()
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        userPhotoUrl != null
                            ? CircleAvatar(
                          backgroundImage: NetworkImage(userPhotoUrl!),
                          radius: 24,
                        )
                            : SvgPicture.asset(AppImages.addPostsProfilePic, height: 48, width: 48),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: userName ?? 'Chargement...',
                              style: GoogleFonts.abel(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              height: 20,
                              padding: EdgeInsets.zero,
                              child: DropdownButton<String>(
                                value: _selectedVisibility,
                                dropdownColor: Colors.grey[900],
                                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                                underline: const SizedBox(),
                                items: ["Public", "Private"].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: CustomText(
                                      text: value,
                                      style: GoogleFonts.abel(
                                        color: Colors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedVisibility = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    /*TextField(
                      style: GoogleFonts.abel(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Add topic name",
                        hintStyle: GoogleFonts.abel(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),*/
                    TextField(
                      controller: _topicController,
                      style: GoogleFonts.abel(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Add topic name",
                        hintStyle: GoogleFonts.abel(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    // _image!=null? Image.memory(File())

                    _imageBytes != null
                        ? Stack(
                      children: [
                        Image.memory(
                          _imageBytes!,
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _imageBytes = null;
                              });
                            },
                            child: SvgPicture.asset(AppImages.redDeleteIcon),
                          ),
                        ),
                      ],
                    )

                        : /*TextField(
                            maxLines: 8,
                            style: GoogleFonts.abel(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: "What do you want to talk about?",
                              hintStyle: GoogleFonts.abel(
                                  color: const Color(0xff7a7a7a),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              filled: true,
                              fillColor: Colors.grey[900],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),*/
                        TextField(
                      controller: _contentController,
                      maxLines: 8,
                      style: GoogleFonts.abel(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "What do you want to talk about?",
                        hintStyle: GoogleFonts.abel(
                            color: const Color(0xff7a7a7a),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () {
                            getImageFromCamera();
                          },
                        ),
                        GestureDetector(
                            onTap: () {
                              getImageFromGallery();
                            },
                            child: SvgPicture.asset(AppImages.photosIcon)),
                        12.horizontalSpace,
                        GestureDetector(
                            onTap: () {
                              pickFile();
                            },
                            child: SvgPicture.asset(AppImages.documentsIcon)),
                        12.horizontalSpace,
                        GestureDetector(
                            onTap: () {
                              PageNavigator(ctx: context)
                                  .nextPage(page: const AskNowScreen());
                            },
                            child:
                                SvgPicture.asset(AppImages.questionMarkIcon)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('http://0.0.0.0:8000/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userName = data['name'];
        userPhotoUrl = data['profile_picture'];
        print('photo profile: $userPhotoUrl');// Doit être une URL
      });
    } else {
      print("Erreur: ${response.statusCode}");
    }
  }



  Future<void> createPost() async {
    if (_topicController.text.isEmpty || _contentController.text.isEmpty) {
      //showToast(context: context, message: "Veuillez remplir tous les champs");
      print('Veuillez remplir tous les champs');
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print("token dans create post : $token");

    var uri = Uri.parse("http://0.0.0.0:8000/api/posts"); // remplace l’URL

    var request = http.MultipartRequest("POST", uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['visibility'] = _selectedVisibility
      ..fields['topic_name'] = _topicController.text
      ..fields['content'] = _contentController.text;

    if (_imageBytes != null) {
      var mimeType = lookupMimeType('', headerBytes: _imageBytes!);
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          _imageBytes!,
          filename: 'upload.jpg',
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ),
      );
    }


    var response = await request.send();
    print("status code de la response : ${response.statusCode}");
    if (response.statusCode == 201) {
      //showToast(context: context, message: "Post created!");
      print('Post created!');
      setState(() {
        isUploaded = true;
        _topicController.clear();
        _contentController.clear();
        _imageBytes = null;
      });

    } else {
      final body = await response.stream.bytesToString();
      print("Error: ${response.statusCode}");
      print(body);
      //showToast(context: context, message: "Erreur lors de l'envoi");

    }
  }

}

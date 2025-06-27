import 'dart:async';
import 'dart:convert';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/widgets/chat_bottom_sheet.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/widgets/chat_bubble_widget.dart';
import 'package:coaching_academy/utils/constants/colors.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/spacing/spacing.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:coaching_academy/utils/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MessageService.dart';

class MessageDetails extends StatefulWidget {
  final String username;
  final String userImage;
  final int receiverId;

  const MessageDetails({
    super.key,
    required this.username,
    required this.userImage,
    required this.receiverId,
  });


  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  final TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Future getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  List messages = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    getCurrentUserId(); // pour définir currentUserId
    fetchMessages(widget.receiverId).then((data) {
      setState(() {
        messages = data;
      });
    });

  }
  int currentUserId = 0;

  Future<void> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final userDataString = prefs.getString('user_data');

      if (userDataString != null) {
        final userData = jsonDecode(userDataString);
        currentUserId = userData['id'] ?? 0;
        print("user current $currentUserId");

      } else {
        currentUserId = 0;
      }

    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        onPress: () {
          Navigator.pop(context);
        },
        title: "Messages",
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.83,
                child: CustomTextField(
                  fillColor: AppColors.backgroundGrey,
                  controller: messageController,
                  hintText: "Your Message",
                  hintTextColor: Colors.white,
                  textColor: Colors.white,
                  suffixIcon: GestureDetector(
                    /*onTap: () {
                      showChatBottomSheet(
                        context,
                        getImageFromCamera,
                        getImageFromGallery,
                      );
                    }*/
                    onTap: () async {
                      final content = messageController.text.trim();
                      if (content.isEmpty) return;

                      final success = await MessageService.sendMessage(
                        receiverId: widget.receiverId,
                        content: content,
                      );

                      if (success) {
                        messageController.clear(); // vide le champ

                        final updatedMessages = await fetchMessages(widget.receiverId);
                        setState(() {
                          messages = updatedMessages;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Message envoyé")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Échec de l'envoi")),
                        );
                      }
                    },

                    child: SvgPicture.asset(
                      AppImages.messageDetailsIcon,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  borderRadius: 20,
                ),
              ),
              ClipRRect(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: SvgPicture.asset(
                    AppImages.voiceMessageIcon,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: messages.isEmpty
          ? const Center(child: Text("Aucun message"))
          : ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          final isMe = msg['sender_id'] == currentUserId;
          return ChatBubbleWidget(
            message: msg['content'],
            time: msg['created_at'],
            isMe: isMe,
          );
        },
      ),

    );
  }

  Future<List<dynamic>> fetchMessages(int receiverId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse("http://localhost:8000/api/messages/$receiverId"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur de chargement des messages');
    }
  }


}

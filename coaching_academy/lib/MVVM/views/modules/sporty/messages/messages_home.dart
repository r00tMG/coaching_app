import 'dart:convert';

import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/message_details.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/widgets/chat_widget.dart';
import 'package:coaching_academy/MVVM/views/modules/sporty/messages/widgets/coach_list_modal.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/navigator/page_navigator.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/Conversation.dart';

class MessagesHome extends StatefulWidget {
  const MessagesHome({super.key});

  @override
  State<MessagesHome> createState() => _MessagesHomeState();
}

class _MessagesHomeState extends State<MessagesHome> {
  late Future<List<Conversation>> futureConversations;

  @override
  void initState() {
    super.initState();
    futureConversations = fetchConversations();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutLeading(
        title: "Messages",
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.6,
                //   child: const Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       // SvgPicture.asset(AppImages.noChatIcon),
                //       // const CustomText(
                //       //   text: "No Chat Found",
                //       //   fontSize: 24,
                //       //   fontWeight: FontWeight.w700,
                //       // ),
                //       // Container(
                //       //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //       //   child: const GreyCustomText(
                //       //     text:
                //       //         "Lorem ipsum dolor sit amet, consectetur dipiscing elit. Ornare sapien, et elit, ornare amet.",
                //       //     fontSize: 14,
                //       //     textAlign: TextAlign.center,
                //       //     fontWeight: FontWeight.w400,
                //       //   ),
                //       // ),

                //     ],
                //   ),
                // ),

                const CustomText(
                  text: "Chats",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                      child: FutureBuilder<List<Conversation>>(
                        future: futureConversations,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Erreur: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('Aucune conversation trouvée.'));
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final conv = snapshot.data![index];
                                return ChatWidget(
                                  onPress: () {
                                    PageNavigator(ctx: context).nextPage(
                                      page: MessageDetails(
                                        username: conv.username,
                                        userImage: conv.userImage,
                                        receiverId: conv.receiverId,
                                      ),
                                    );
                                  },
                                  title: conv.username,
                                  subtitle: conv.lastMessage,
                                  time: conv.lastTime,
                                  imagePath: conv.userImage,
                                );
                              },
                            );
                            ;
                          }
                        },
                      ),
                    ),
                  /*children: [

                    ChatWidget(
                      onPress: () {
                        PageNavigator(ctx: context).nextPage(
                            page: const MessageDetails(
                          username: "Jurassic Remo",
                          userImage: AppImages.avatar2,
                        ));
                      },
                      title: "Jurassic Remo",
                      subtitle: "Typing",
                      time: "04:22PM",
                      messageCount: "3",
                      imagePath: AppImages.avatar2,
                    ),
                    ChatWidget(
                      onPress: () {
                        PageNavigator(ctx: context).nextPage(
                            page: const MessageDetails(
                          username: "Darlene Robertson",
                          userImage: AppImages.avatar3,
                        ));
                      },
                      title: "Darlene Robertson",
                      subtitle: "Okay , I,ll do this",
                      time: "04:22PM",
                      imagePath: AppImages.avatar3,
                    ),
                    ChatWidget(
                      onPress: () {
                        PageNavigator(ctx: context).nextPage(
                            page: const MessageDetails(
                          username: "Jurassic Remo",
                          userImage: AppImages.avatar4,
                        ));
                      },
                      title: "Jurassic Remo",
                      subtitle: "Typing",
                      time: "04:22PM",
                      imagePath: AppImages.avatar4,
                    ),
                    ChatWidget(
                      onPress: () {
                        PageNavigator(ctx: context).nextPage(
                            page: const MessageDetails(
                          username: "Jurassic Remo",
                          userImage: AppImages.avatar5,
                        ));
                      },
                      title: "Jurassic Remo",
                      subtitle: "Typing",
                      time: "04:22PM",
                      imagePath: AppImages.avatar5,
                    ),
                  ],*/
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => CoachListModal(),
          );
        },
      ),
    );
  }



  Future<List<Conversation>> fetchConversations() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse("http://localhost:8000/api/conversations"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      print("data response api conversation: $data");
      return data.map((item) => Conversation.fromJson(item)).toList();
    } else {
      throw Exception("Échec du chargement des conversations");
    }
  }

}

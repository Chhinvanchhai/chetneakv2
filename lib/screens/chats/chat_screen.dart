import 'package:chetneak_v2/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_service.dart';
import 'body_message.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  final bool isGroup;

  ChatScreen({required this.chatId, required this.isGroup});

  final ChatServiceController controller = Get.put(ChatServiceController());
  final UserController userControoler = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    controller.initialize(chatId, isGroup);

    return Scaffold(
      appBar: AppBar(
        title: Text(isGroup ? 'Group Chat' : 'Chat'),
      ),
      body: BodyMessage(chatId: chatId),
    );
  }
}

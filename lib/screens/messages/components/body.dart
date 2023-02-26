import 'package:get/get.dart';
import 'package:chetneak_v2/constants.dart';
import 'package:chetneak_v2/controllers/user_controller.dart';
import 'package:chetneak_v2/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  final String? messageId;
  final UserController userController = Get.find();
  Body({Key? key, this.messageId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(
                () => ListView.builder(
                    reverse: true,
                    controller: userController.scrollController,
                    itemCount: userController.demeChatMessages.length,
                    itemBuilder: (context, index) {
                      if (index < userController.demeChatMessages.length) {
                        return Message(
                            message: userController.demeChatMessages[index]);
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    }),
              )),
        ),
        ChatInputField(messageId: messageId),
      ],
    );
  }
}

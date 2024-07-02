import 'package:chetneak_v2/screens/chats/chat_service.dart';
import 'package:chetneak_v2/screens/chats/components/message.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/constants.dart';
import 'package:chetneak_v2/models/ChatMessage.dart';
import 'package:flutter/material.dart';

import 'components/chat_input_field.dart';

class BodyMessage extends StatelessWidget {
  final ChatServiceController controller = Get.put(ChatServiceController());
  final String chatId;
  BodyMessage({Key? key, required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(() => ListView.builder(
                    controller: controller.scrollController,
                    reverse: true,
                    itemCount: controller.messages.length +
                        (controller.isLoadingMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.messages.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var message = controller.messages[index];
                      var data = message.data() as Map<String, dynamic>;
                      var isSender =
                          data['senderId'] == controller.auth.currentUser!.uid;

                      return Message(
                          message: ChatMessage(
                              text: data["text"],
                              messageType: ChatMessageType.text,
                              messageStatus: MessageStatus.not_view,
                              isSender: isSender));
                    },
                  ))),
        ),
        ChatInputField(chatId: chatId),
      ],
    );
  }
}

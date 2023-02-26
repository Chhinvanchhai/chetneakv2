import 'package:get/get.dart';
import 'package:chetneak_v2/components/filled_outline_button.dart';
import 'package:chetneak_v2/constants.dart';
import 'package:chetneak_v2/controllers/user_controller.dart';
import 'package:chetneak_v2/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'chat_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final UserController userController = Get.put(UserController());
  bool isAcitve = false;
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(
                  press: () {
                    setState(() {
                      isAcitve = false;
                    });
                  },
                  isFilled: isAcitve ? false : true,
                  text: "Recent Message"),
              SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {
                  setState(() {
                    isAcitve = true;
                  });
                },
                text: "Active",
                isFilled: !isAcitve ? false : true,
              ),
            ],
          ),
        ),
        Expanded(
          child: !isAcitve
              ? Obx(() => ListView.builder(
                    itemCount: userController.users.length,
                    itemBuilder: (context, index) => ChatCard(
                      chat: userController.users[index],
                      press: () => Get.to(
                          MessagesScreen(user: userController.users[index])),
                      // press: () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         MessagesScreen(user: userController.users[index]),
                      //   ),
                      // ),
                    ),
                  ))
              : Container(
                  child: Text('is acrtive people'),
                ),
        ),
      ],
    );
  }
}

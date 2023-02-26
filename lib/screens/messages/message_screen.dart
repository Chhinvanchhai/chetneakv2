import 'package:get/get.dart';
import 'package:chetneak_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:chetneak_v2/controllers/user_controller.dart';

import 'components/body.dart';
import 'package:chetneak_v2/models/User.dart';

class MessagesScreen extends StatelessWidget {
  final Users user;
  MessagesScreen({Key? key, required this.user}) : super(key: key);
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    userController.getUserGropuIdMessage(user.docGroupId);
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(messageId: user.docGroupId),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          user.avatar != ''
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage:
                      NetworkImage(user.avatar ?? 'assets/images/user.png'),
                )
              : CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}

class Final {}

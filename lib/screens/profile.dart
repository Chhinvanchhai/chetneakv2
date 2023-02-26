import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/controllers/notification_controller.dart';
import 'package:chetneak_v2/controllers/profile_controller.dart';
import 'package:chetneak_v2/screens/test/image_picker.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());
  final NotifcationController notifController =
      Get.put(NotifcationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prifile'),
      ),
      body: Column(
        children: [
          Text('Prile name: ${profileController.profile['displayName']}'),
          IconButton(
            onPressed: () => profileController.signOutMe(),
            icon: Icon(Icons.logout_outlined),
          ),
          IconButton(
            onPressed: () => notifController.localNotication(),
            icon: Icon(Icons.notification_add_outlined),
          ),
          IamgePickerWidget()
        ],
      ),
    );
  }
}

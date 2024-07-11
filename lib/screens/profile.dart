import 'package:chetneak_v2/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/images/user_2.png'), // Replace with your image path
            ),
            SizedBox(height: 10),
            Text(
              'Nicolas Adams',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'nicolasadams@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Upgrade to PRO'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ProfileMenuItem(
                    icon: Icons.privacy_tip,
                    text: 'Privacy',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.history,
                    text: 'Purchase History',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.help,
                    text: 'Help & Support',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.person_add,
                    text: 'Invite a Friend',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      profileController.signOutMe();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

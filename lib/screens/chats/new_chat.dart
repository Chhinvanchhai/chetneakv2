import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../controllers/chat_controller.dart';

class CreateChatScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var chatService = Get.put(ChatService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Chat'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var users = snapshot.data!.docs;
          print(("user=============="));
          print(users.length);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              var currentUser = _auth.currentUser;

              // Skip current user
              if (user.id == currentUser!.uid) {
                return Container();
              }

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['avatar']),
                ),
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () {
                  // Create a new chat with the selected user
                  chatService.createNewChat(user.id).then((_) {
                    Get.back();
                    Get.snackbar('Success', 'New chat created!');
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}

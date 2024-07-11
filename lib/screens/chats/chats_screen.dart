import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';

class ListChatScreen extends StatefulWidget {
  @override
  _ListChatScreenState createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();
  final int _limitIncrement = 20;
  int _limit = 20;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0 && !_isLoadingMore) {
        setState(() {
          _isLoadingMore = true;
          _limit += _limitIncrement;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.toNamed('/new-group');
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('chats')
            .where('members', arrayContains: _auth.currentUser!.uid)
            .limit(_limit)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var chatDocs = chatSnapshot.data!.docs;

          return ListView.builder(
            controller: _scrollController,
            itemCount: chatDocs.length + (_isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == chatDocs.length) {
                return Center(child: CircularProgressIndicator());
              }

              var chat = chatDocs[index];
              var isGroup = chat['isGroup'] as bool;
              var chatId = chat.id;

              return ListTile(
                leading: CircleAvatar(
                  child: Icon(isGroup ? Icons.group : Icons.person),
                ),
                title: FutureBuilder<DocumentSnapshot>(
                  future: _getChatTitle(chat),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    }

                    if (!snapshot.hasData || snapshot.data?.data() == null) {
                      return Text('Unknown');
                    }

                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    var title = data['name'] ?? 'Chat';
                    return Text(title);
                  },
                ),
                subtitle: Text(isGroup ? 'Group Chat' : 'Personal Chat'),
                onTap: () {
                  Get.to(ChatScreen(chatId: chatId, isGroup: isGroup));
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<DocumentSnapshot> _getChatTitle(DocumentSnapshot chat) async {
    var isGroup = chat['isGroup'] as bool;
    var currentUser = _auth.currentUser;

    if (isGroup) {
      return _firestore.collection('groups').doc(chat.id).get();
    } else {
      var members = List<String>.from(chat['members']);
      var otherUserId = members.firstWhere((id) => id != currentUser!.uid);
      return _firestore.collection('users').doc(otherUserId).get();
    }
  }
}

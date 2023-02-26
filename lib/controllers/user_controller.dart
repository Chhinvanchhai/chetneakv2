import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chetneak_v2/models/ChatMessage.dart';
import 'package:chetneak_v2/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  var users = <Users>[].obs;
  final scrollController = ScrollController();
  var page = 1;
  bool isLoadMore = false;
  var storId = '';
  List<DocumentSnapshot>? documentList;
  List demeChatMessages = [
    ChatMessage(
      text: "Hi Sajol,",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: false,
    ),
    ChatMessage(
      text: "Hello, How are you?",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: true,
    ),
    ChatMessage(
      text: "",
      messageType: ChatMessageType.audio,
      messageStatus: MessageStatus.viewed,
      isSender: false,
    ),
    ChatMessage(
      text: "",
      messageType: ChatMessageType.video,
      messageStatus: MessageStatus.viewed,
      isSender: true,
    ),
    ChatMessage(
      text: "Error happend",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.not_sent,
      isSender: true,
    ),
    ChatMessage(
      text: "This looks great man!!",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: false,
    ),
    ChatMessage(
      text: "Glad you like it",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.not_view,
      isSender: true,
    ),
  ].obs;
  @override
  void onInit() {
    getChatterUser();
    print(users);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isLoadMore = true;
        page += 1;
        print("Reach Bottom Of screen!!!!!!!!!!====> $page");
        getUserGropuIdMessageMorePage();
      }
    });
    super.onInit();
  }

  getChatterUser() {
    User? userAuthFire = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('group')
        .where('members', arrayContainsAny: [userAuthFire!.uid])
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            var chater =
                doc['members'].where((i) => i != userAuthFire.uid).toList();
            print('chater id = $chater');
            FirebaseFirestore.instance
                .collection('users')
                .doc(chater[0])
                .get()
                .then((DocumentSnapshot documentSnapshot) {
              var getUserFire = documentSnapshot.data();
              Map u = getUserFire as Map;
              print('doc group id = ${documentSnapshot.id}');
              users.add(Users(
                  email: u['email'],
                  name: u['name'],
                  avatar: u['avatar'],
                  docGroupId: doc.id,
                  id: chater[0]));
            });
          });
        });
    update();
  }

  getUserGropuIdMessage(id) {
    // print('doc group id = $id');
    storId = id;
    final box = GetStorage();
    Map profile = box.read('user') as Map;
    List getAllMessage = [].obs;
    demeChatMessages = [].obs;
    FirebaseFirestore.instance
        .collection('messages')
        .doc(id)
        .collection('message')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      // demeChatMessages = [].obs;
      getAllMessage.clear();
      this.demeChatMessages.clear();
      querySnapshot.docs.forEach((doc) {
        documentList = querySnapshot.docs;
        Map message = doc.data() as Map;
        print('user ==== ${message['user']['email']}');
        bool isSender;
        if (profile['email'] == message['user']['email']) {
          isSender = true;
        } else {
          isSender = false;
        }
        getAllMessage.add(ChatMessage(
            text: message['text'],
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.viewed,
            isSender: isSender));
      });
      demeChatMessages = getAllMessage;
    });

    update();
  }

  getUserGropuIdMessageMorePage() {
    final box = GetStorage();
    Map profile = box.read('user') as Map;
    List getAllMessage = [];
    print("(documentList![documentList!.length - 1]====" +
        documentList![documentList!.length - 1].toString());
    if (documentList != null) {
      FirebaseFirestore.instance
          .collection('messages')
          .doc(storId)
          .collection('message')
          .orderBy('createdAt', descending: true)
          .startAfterDocument(documentList![documentList!.length - 1])
          .limit(20)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          return;
        }
        documentList = querySnapshot.docs;
        querySnapshot.docs.forEach((doc) {
          Map message = doc.data() as Map;
          bool isSender;
          if (profile['email'] == message['user']['email']) {
            isSender = true;
          } else {
            isSender = false;
          }
          getAllMessage.add(ChatMessage(
              text: message['text'],
              messageType: ChatMessageType.text,
              messageStatus: MessageStatus.viewed,
              isSender: isSender));
        });
        demeChatMessages.addAll(getAllMessage);
      });
    }
  }

  sendMessage(id, text) {
    // print('doc group id = $id');
    final box = GetStorage();
    Map profile = box.read('user') as Map;
    FirebaseFirestore.instance
        .collection('messages')
        .doc(id)
        .collection('message')
        .add({
          'text': text,
          'createdAt': new DateTime.now(),
          'image': "",
          'video': '',
          'send': true,
          'received': true,
          'audio': '',
          'pending': true,
          'user': profile
        })
        .then((value) => print('send'))
        .catchError((error) => print("Failed to add user: $error"));
  }
  //  testing method

  Future fetchFirstList() async {
    FirebaseFirestore.instance
        .collection('messages')
        .doc(storId)
        .collection('message')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get()
        .then((QuerySnapshot querySnapshot) {
      // documentList = querySnapshot.getD
      documentList = querySnapshot.docs;
      // querySnapshot.docs.forEach((doc) {});
    });
  }
}

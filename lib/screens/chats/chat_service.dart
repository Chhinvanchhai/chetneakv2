import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatServiceController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ScrollController scrollController = ScrollController();
  final int limitIncrement = 20;

  var messages = <DocumentSnapshot>[].obs;
  var limit = 20.obs;
  var isLoadingMore = false.obs;

  late StreamSubscription messageSubscription;

  String chatId = '';
  bool isGroup = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
  }

  // @override
  // void onClose() {
  //   scrollController.dispose();
  //   messageSubscription.cancel();
  //   super.onClose();
  // }

  void initialize(String chatId, bool isGroup) {
    this.chatId = chatId;
    this.isGroup = isGroup;
    loadMessages();
  }

  void scrollListener() {
    if (scrollController.position.pixels == 0 && !isLoadingMore.value) {
      isLoadingMore.value = true;
      limit.value += limitIncrement;
      loadMoreMessages();
    }
  }

  void loadMessages() {
    messageSubscription = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(limit.value)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs;
    });
  }

  Future<void> loadMoreMessages() async {
    try {
      var query = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .limit(limit.value);

      var snapshot = await query.get();
      messages.value = snapshot.docs;
      isLoadingMore.value = false;
    } catch (e) {
      print("Error loading more messages: $e");
      isLoadingMore.value = false;
    }
  }

  Future<void> sendMessage(String text, String chatId) async {
    if (text.trim().isEmpty) return;

    User? currentUser = auth.currentUser;
    if (currentUser == null) return;

    try {
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'text': text,
        'senderId': currentUser.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': text,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}

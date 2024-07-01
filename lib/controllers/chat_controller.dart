import 'package:chetneak_v2/models/ChatMessage.dart';
import 'package:chetneak_v2/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage _box = GetStorage();
  RxList<ChatMessage> demeChatMessages = <ChatMessage>[].obs;
  List<DocumentSnapshot> documentList = [];
  String? storId;
  var users = <Users>[].obs;

  // Function to create a new direct chat
  Future<void> createNewChat(String otherUserId) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    String currentUserId = currentUser.uid;

    // Check if chat already exists
    QuerySnapshot existingChat = await _firestore
        .collection('chats')
        .where('members', arrayContains: currentUserId)
        .get();

    for (var doc in existingChat.docs) {
      List<dynamic> members = doc['members'];
      if (members.contains(otherUserId)) {
        print('Chat already exists with ID: ${doc.id}');
        return;
      }
    }

    // Create new chat document
    DocumentReference newChatRef = await _firestore.collection('chats').add({
      'isGroup': false,
      'members': [currentUserId, otherUserId],
      'lastMessage': '',
      'lastUpdated': FieldValue.serverTimestamp()
    });

    print('New chat created with ID: ${newChatRef.id}');
  }

  // Function to create a new group chat
  Future<void> createGroupChat(String groupName, List<String> userIds) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    String currentUserId = currentUser.uid;
    userIds.add(currentUserId);

    // Create new group chat document
    DocumentReference newGroupRef = await _firestore.collection('groups').add({
      'name': groupName,
      'description': '',
      'adminId': currentUserId,
      'members': userIds,
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': '',
      'lastUpdated': FieldValue.serverTimestamp()
    });

    print('New group chat created with ID: ${newGroupRef.id}');
  }

  // Function to invite a user to an existing group
  Future<void> inviteUserToGroup(String groupId, String newUserId) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    DocumentReference groupRef = _firestore.collection('groups').doc(groupId);
    DocumentSnapshot groupSnapshot = await groupRef.get();

    if (groupSnapshot.exists) {
      List<dynamic> members = groupSnapshot['members'];
      if (!members.contains(newUserId)) {
        members.add(newUserId);
        await groupRef.update(
            {'members': members, 'lastUpdated': FieldValue.serverTimestamp()});
        print('User $newUserId invited to group $groupId');
      } else {
        print('User is already a member of the group');
      }
    } else {
      print('Group does not exist');
    }
  }

  // Function to fetch group members
  Future<void> getGroupMembers() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    String currentUserId = currentUser.uid;

    _firestore
        .collection('groups')
        .where('members', arrayContains: currentUserId)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        List<dynamic> members = doc['members'];
        List otherMembers = members.where((id) => id != currentUserId).toList();

        for (String memberId in otherMembers) {
          DocumentSnapshot userSnapshot =
              await _firestore.collection('users').doc(memberId).get();
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          print('Member ID: $memberId');
          print('User Data: ${userData['name']}');

          // Add user to your users list
          users.add(Users(
            email: userData['email'],
            name: userData['name'],
            avatar: userData['avatar'],
            docGroupId: doc.id,
            id: memberId,
          ));
        }
      }
    });

    update();
  }

  // Function to fetch group messages
  void getGroupMessages(String groupId) {
    storId = groupId;

    Map<String, dynamic> profile = _box.read('user') as Map<String, dynamic>;
    String userEmail = profile['email'];

    _firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      List<ChatMessage> allMessages = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> message = doc.data() as Map<String, dynamic>;
        bool isSender = userEmail == message['senderId'];

        allMessages.add(ChatMessage(
          text: message['content'],
          messageType: ChatMessageType.text,
          messageStatus: MessageStatus.viewed,
          isSender: isSender,
        ));
      }

      documentList = querySnapshot.docs;
      demeChatMessages.value = allMessages;
    });

    update();
  }

  // Function to get listing of personal and group chats
  Future<void> getChats() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return;

    String currentUserId = currentUser.uid;

    // Personal chats
    _firestore
        .collection('chats')
        .where('members', arrayContains: currentUserId)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        List<dynamic> members = doc['members'];
        if (members.length == 2) {
          print('Personal chat ID: ${doc.id}');
        }
      }
    });

    // Group chats
    _firestore
        .collection('groups')
        .where('members', arrayContains: currentUserId)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print('Group chat ID: ${doc.id}');
      }
    });
  }

  // Function to fetch personal messages for a given chat ID
  void getPersonalMessages(String chatId) {
    storId = chatId;

    Map<String, dynamic> profile = _box.read('user') as Map<String, dynamic>;
    String userEmail = profile['email'];

    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      List<ChatMessage> allMessages = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> message = doc.data() as Map<String, dynamic>;
        bool isSender = userEmail == message['senderId'];

        allMessages.add(ChatMessage(
          text: message['content'],
          messageType: ChatMessageType.text,
          messageStatus: MessageStatus.viewed,
          isSender: isSender,
        ));
      }

      documentList = querySnapshot.docs;
      demeChatMessages.value = allMessages;
    });

    update();
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _groupNameController = TextEditingController();
  final List<String> _selectedUsers = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _isLoading ? null : _createGroup,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var users = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];
                    var currentUser = _auth.currentUser;

                    // Skip current user
                    if (user.id == currentUser!.uid) {
                      return Container();
                    }

                    var userName = user.exists ? user['name'] : 'Unknown';
                    var userEmail = user.exists ? user['email'] : 'Unknown';
                    var userAvatar = user.exists ? user['avatar'] : '';

                    return ListTile(
                      leading: userAvatar.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(userAvatar))
                          : CircleAvatar(child: Icon(Icons.person)),
                      title: Text(userName),
                      subtitle: Text(userEmail),
                      trailing: Checkbox(
                        value: _selectedUsers.contains(user.id),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value!) {
                              _selectedUsers.add(user.id);
                            } else {
                              _selectedUsers.remove(user.id);
                            }
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createGroup() async {
    if (_groupNameController.text.isEmpty || _selectedUsers.isEmpty) {
      Get.snackbar(
          'Error', 'Please provide a group name and select at least one user.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    User? currentUser = _auth.currentUser;

    // Add the current user to the selected users
    _selectedUsers.add(currentUser!.uid);

    DocumentReference groupRef = await _firestore.collection('groups').add({
      'name': _groupNameController.text,
      'members': _selectedUsers,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Add a new chat document for the group
    await _firestore.collection('chats').doc(groupRef.id).set({
      'isGroup': true,
      'members': _selectedUsers,
      'lastMessage': '',
      'lastUpdated': FieldValue.serverTimestamp(),
    });

    setState(() {
      _isLoading = false;
    });

    Get.back();
    Get.snackbar('Success', 'Group created successfully!');
  }
}

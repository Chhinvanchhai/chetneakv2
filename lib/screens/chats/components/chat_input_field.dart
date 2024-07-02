import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants.dart';
import '../chat_service.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class ChatInputField extends StatefulWidget {
  final String chatId;
  const ChatInputField({
    required this.chatId,
    Key? key,
  }) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool isTyping = false;
  final picker = ImagePicker();
  late String _imageFile;
  File? image;
  var sms;
  UserController userController = Get.find();
  final TextEditingController _controller = new TextEditingController();
  final ChatServiceController controller = Get.put(ChatServiceController());

  void handleMessage(text) {
    setState(() {
      sms = text;
    });
    if (sms == '') {
      isTyping = false;
    } else {
      isTyping = true;
    }
  }

  void sendMessage() {
    controller.sendMessage(
      sms,
      widget.chatId,
    );
    setState(() {
      sms = '';
    });
    isTyping = false;
    _controller.clear();
  }

  Future<void> uploadFile(File filePath) async {
    // try {
    //   await firebase_storage.FirebaseStorage.instance
    //       .ref('uploads/file-to-upload.png')
    //       .putFile(filePath);
    // } catch (e) {
    //   print("catch firestore= $e");
    // }
  }

  Future<void> handleTaskExample2(String filePath) async {
    // File largeFile = File(filePath);
    // firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
    //     .ref('message/')
    //     .putFile(largeFile);

    // task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
    //   print('Task state: ${snapshot.state}');
    //   print(
    //       'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    // }, onError: (e) {
    //   // The final snapshot is also available on the task via `.snapshot`,
    //   // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
    //   print(task.snapshot);

    //   if (e.code == 'permission-denied') {
    //     print('User does not have permission to upload to this reference.');
    //   }
    // });

    // // We can still optionally use the Future alongside the stream.
    // try {
    //   await task;
    //   print('Upload complete.');
    // } catch (e) {
    //   print('User does not have permission to upload to this reference.');

    //   // ...
    // }
  }

  Future getMyImage() async {
    final pickGaleryImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickGaleryImage != null) {
      handleTaskExample2(pickGaleryImage.path);
      setState(() {
        image = File(pickGaleryImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.mic, color: kPrimaryColor),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        onChanged: (text) => handleMessage(text),
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    !isTyping
                        ? Row(
                            children: [
                              IconButton(
                                  onPressed: () => attactmentFile(context),
                                  icon: Icon(
                                    Icons.attach_file,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.64),
                                  )),
                              SizedBox(width: kDefaultPadding / 8),
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(0.64),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              SizedBox(width: kDefaultPadding / 4),
                              InkWell(
                                onTap: () => sendMessage(),
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  attactmentFile(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Image'),
                    onTap: getMyImage),
                ListTile(
                  leading: Icon(Icons.videocam),
                  title: Text('Video'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('File'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }
}

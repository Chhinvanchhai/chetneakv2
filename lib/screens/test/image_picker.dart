import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IamgePickerWidget extends StatefulWidget {
  const IamgePickerWidget({Key? key}) : super(key: key);

  @override
  State<IamgePickerWidget> createState() => _IamgePickerWidgetState();
}

class _IamgePickerWidgetState extends State<IamgePickerWidget> {
  final picker = ImagePicker();
  late String _imageFile;
  File? image;
  @override
  void initState() {
    super.initState();
  }

  Future pickImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future getMyImage() async {
    final pickGaleryImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickGaleryImage != null) {
      setState(() {
        image = File(pickGaleryImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: image == null
                ? Text('Image not select yet')
                : Image.file(image!),
            height: 300,
          ),
          TextButton(
              onPressed: getMyImage, child: Text('Picker gallery Image')),
          TextButton(
              onPressed: pickImageCamera, child: Text('Picker cammer Iamge'))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerCompoent extends StatelessWidget {
  const FilePickerCompoent({Key? key}) : super(key: key);
    showAttachmentBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Image'),
                      onTap: (){}),
                  ListTile(
                      leading: Icon(Icons.videocam),
                      title: Text('Video'),
                       onTap: () {},),
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

    showFilePicker(FileType fileType) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
    }

  @override
  Widget build(BuildContext context) {
  

    return Container();
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Cricle extends StatefulWidget {
  Cricle(this.imagepickerfn);

  final void Function(File createimage) imagepickerfn;
  @override
  _CricleState createState() => _CricleState();
}

class _CricleState extends State<Cricle> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    widget.imagepickerfn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _image != null ? FileImage(_image) : null,
          backgroundColor: Colors.purple,
        ),
        // ignore: deprecated_member_use
        FlatButton.icon(
          onPressed: getImage,
          icon: Icon(
            Icons.image,
            color: Colors.white,
          ),
          label: Text(
            'Add the Image',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
    // ignore: deprecated_member_use
  }
}

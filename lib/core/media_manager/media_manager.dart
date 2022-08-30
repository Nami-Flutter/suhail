import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soheel_app/constants.dart';

import '../router/router.dart';

class MediaManager {

  // static Future<File?> pickFile() async{
  //   final pickedFile = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     allowedExtensions: [
  //       'pdf',
  //       'PDF',
  //     ],
  //     type: FileType.custom,
  //   );
  //   if(pickedFile == null || pickedFile.files.isEmpty) return null;
  //   return File(pickedFile.files.first.path!);
  // }

  static Future<File?> pickVideoFromGallery()async{
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if(pickedFile == null) return null;
    return File(pickedFile.path);
  }

  static Future<File?> pickImageFromGallery()async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile == null) return null;
    return File(pickedFile.path);
  }

  static Future<File?> pickImageFromCamera()async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 500,maxWidth: 1024, imageQuality: 25);
    if(pickedFile == null) return null;
    return File(pickedFile.path);
  }

  /// final file = await MediaManager.showImageDialog();
  /// instead of
  /// final file = await ImagePicker().pickImage(source: ImageSource.gallery);
  static Future<File?> showImageDialog() async {
    final file = await showCupertinoDialog(
      context: RouteManager.currentContext,
      barrierDismissible: true,
      builder: (BuildContext context) => _ImageDialog(),
    );
    return file;
  }

}

class _ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('التقط الصورة من ...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      actions: [
        CupertinoButton(
          child: Text(
            'الكاميرا',
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
          onPressed: () async {
            final file = await MediaManager.pickImageFromCamera();
            Navigator.pop(context, file);
          },
        ),
        CupertinoButton(
          child: Text(
            'الاستوديو',
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
          onPressed: () async {
            final file = await MediaManager.pickImageFromGallery();
            Navigator.pop(context, file);
          },
        ),
        CupertinoButton(
          child: Text(
            'الغاء',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
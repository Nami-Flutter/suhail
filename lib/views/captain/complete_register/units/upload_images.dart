import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soheel_app/views/captain/complete_register/cubit/cubit.dart';

import '../../../../constants.dart';

class UploadImages extends StatelessWidget {
  const UploadImages({Key? key, required this.images, required this.onAdd, required this.onRemove}) : super(key: key);

  final List<File> images;
  final void Function() onAdd;
  final void Function(File) onRemove;


  @override
  Widget build(BuildContext context) {
    return Wrap(
      // crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: [
        ...images
            .map((e) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(e.path),
                    fit: BoxFit.cover,
                    width: sizeFromWidth(4.5),
                    height:80,
                  )),
            ),
            Positioned(
                child: IconButton(
                  onPressed: () => onRemove(e),
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: kRedColor,
                    size: 16,
                  ),
                ),),
          ],
        ))
            .toList(),
        images.length >= 2 ? SizedBox() : MaterialButton(
          onPressed: onAdd,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor),
            child: Icon(
              FontAwesomeIcons.camera,
              color: kDarkGreyColor,
            ),
          ),
        ),
      ],
    );
  }
}

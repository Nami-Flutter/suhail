import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soheel_app/views/user/requset_trip/cubit/cubit.dart';

import '../../../../constants.dart';

class PicsUploads extends StatefulWidget {
  const PicsUploads({Key? key}) : super(key: key);

  @override
  _PicsUploadsState createState() => _PicsUploadsState();
}

class _PicsUploadsState extends State<PicsUploads> {
  @override
  Widget build(BuildContext context) {
    final cubit = AddTripCubit.of(context);
    return Wrap(
      // crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: [
        ...cubit.imageFileList.map((e) => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(e.path),
                            fit: BoxFit.cover,
                            width: sizeFromWidth(3.5),
                            height: 100,
                          )),
                    ),
                    Positioned(
                        child: IconButton(
                      onPressed: () {
                        cubit.imageFileList.remove(e);
                        setState(() {});
                      },
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: kRedColor,
                        size: 16,
                      ),
                    ),),
                  ],
                ))
            .toList(),
        if (cubit.imageFileList.length < 5)
          cubit.imageFileList.isEmpty ?  MaterialButton(
            onPressed: () {
              cubit.selectImages();
            },
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
          ) : MaterialButton(
                  onPressed: cubit.selectImages,
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kWhiteColor),
                    child: Icon(
                      FontAwesomeIcons.camera,
                      color: kDarkGreyColor,
                    ),
                  ),
                )
      ],
    );
  }

}

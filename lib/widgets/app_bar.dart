import 'package:flutter/material.dart';

import '../constants.dart';

appBar({
  String? title,
  bool centerTitle = false,
  Widget? leading,
  List<Widget>? actions,
  double? elevation = 0,
}) => AppBar(
  elevation: elevation,
  backgroundColor: kPrimaryColor,
  title: Text(title ?? '',style: TextStyle(color: kWhiteColor,fontSize: 22,fontWeight: FontWeight.w700)),
  centerTitle: centerTitle,
  leading: leading,
  actions: actions,
 iconTheme: IconThemeData(
   color: kWhiteColor
 ),

);
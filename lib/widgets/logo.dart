import 'package:flutter/material.dart';

import '../constants.dart';

class Logo extends StatelessWidget {
  final double heightFraction;
  final Color? color;

  Logo({this.heightFraction = 3, this.color}){
    withBG = false;
  }

  Logo.bg({this.heightFraction = 3, this.color}){
    withBG = true;
  }
  late final bool withBG;

  @override
  Widget build(BuildContext context) {
    if(withBG){
      return _logoBG();
    }
    return _logo();
  }

  Widget _logo()=> SizedBox(
      height: sizeFromHeight(heightFraction),
      child: Image.asset(getAsset('logo'), color: color,));

  Widget _logoBG()=> Container(
    padding: EdgeInsets.all(6),
    child: CircleAvatar(
      backgroundColor: kWhiteColor,
        radius: sizeFromHeight(8),
        child: Image.asset(getAsset('logo'), color: color)),
    decoration: BoxDecoration(
      color: kGreyColor,
      shape: BoxShape.circle
    ),
  );

}

import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    Key? key,
    required this.title,
    this.fontSize,
    this.color = Colors.black,
    this.textDecoration,
    this.fontWeight = FontWeight.w700,
    this.textAlign,
    this.overflow,
    this.maxLines
  }) : super(key: key);

  final String title;
  final double? fontSize;
  final Color color;
  final TextDecoration? textDecoration;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize,
        decoration: textDecoration,
        overflow: overflow,
      ),
      maxLines: maxLines,
    );
  }
}
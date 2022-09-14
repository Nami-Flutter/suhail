import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    Key? key,
    required this.title,
    this.fontSize,
    this.color = Colors.black,
    this.textDecoration,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.vMargin = 0,
    this.hMargin = 0,
  }) : super(key: key);

  final String title;
  final double? fontSize;
  final Color color;
  final TextDecoration? textDecoration;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double vMargin;
  final double hMargin;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vMargin, horizontal: hMargin),
      child: Text(
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
      ),
    );
  }
}
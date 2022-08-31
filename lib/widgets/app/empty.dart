import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soheel_app/constants.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset('assets/images/empty.json',width: sizeFromWidth(1.5)),
        ),
        Text('لا توجد رحلات',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: kPrimaryColor),)
      ],
    );
  }
}

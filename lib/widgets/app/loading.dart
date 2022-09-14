import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.vMargin = 0}) : super(key: key);

  final double vMargin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vMargin),
      child: Center(
        child: Lottie.asset('assets/images/load.json',width: 100),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future Function() onRefresh;
  final Widget child;

  CustomRefreshIndicator({required this.onRefresh,required this.child});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: child,
      color: kPrimaryColor,
      // backgroundColor: loggedUser.isCaptain ? kYellowColor : kBlueColor,
    );
  }
}

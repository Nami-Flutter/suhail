import 'package:flutter/cupertino.dart';

class PopScaffold extends StatelessWidget {
  final Widget child;

  PopScaffold({required this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: Directionality(
          child: child,
          textDirection: TextDirection.rtl,
        ),
      ),
      onTap:
      // Platform.isIOS ?
          ()=> FocusScope.of(context)..unfocus()..requestFocus(FocusNode())
          // : null,
    );
  }
}

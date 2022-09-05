import 'package:flutter/material.dart';
import '../constants.dart';

class ConfirmButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final double? verticalMargin;
  final double? horizontalMargin;
  final Color? color;
  final bool? border;
  final IconData? icon;
  final Color? fontColor;
  late final bool _isStretched;
  late final bool _isExpanded;
  late final int _flex;
  final Widget? child;

  ConfirmButton({this.onPressed, this.child, this.title, this.verticalMargin = 3, this.horizontalMargin = 0, this.color = kPrimaryColor, this.border = false, this.icon, this.fontColor,}){
    _isStretched = true;
    _isExpanded = false;
  }

  ConfirmButton.shortened({this.onPressed, this.child,this.title, this.verticalMargin = 3, this.horizontalMargin = 0, this.color = kPrimaryColor, this.border = false, this.icon, this.fontColor}){
    _isStretched = false;
    _isExpanded = false;
  }

  ConfirmButton.expanded({int flex  = 1,this.onPressed, this.child,this.title, this.verticalMargin = 3, this.horizontalMargin = 0, this.color = kPrimaryColor, this.border = false, this.icon, this.fontColor}){
    _isStretched = false;
    _isExpanded = true;
    this._flex = flex;
  }

  @override
  Widget build(BuildContext context) {
    return _isExpanded
        ? Expanded(flex: _flex, child: _getButton)
        : _getButton;
  }

  Widget get _getButton => Column(
    crossAxisAlignment: _isStretched ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: verticalMargin!,horizontal: horizontalMargin!),
        child: InkWell(
          onTap: onPressed,
          radius: 10,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: child ?? (icon == null ? _textTitleWidget : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(icon,color: Colors.white,size: 20,),
                  ),
                  _textTitleWidget,
                ],
              )),
            ),
            decoration: BoxDecoration(
              color: border == true ? Colors.transparent : color ?? kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: color!,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget get _textTitleWidget => Text(
    title!,
    style: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold,color: border! ? color : Colors.white),
  );

}
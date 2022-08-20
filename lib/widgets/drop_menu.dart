import 'package:flutter/material.dart';
import '../constants.dart';
import '../core/validator/validation.dart';

class DropMenu extends StatefulWidget {
  final bool hasBorder;
  final String? upperText;
  final String? hint;
  final dynamic value;

  final List items;
  final bool isItemsModel;
  final Function(dynamic)? onChanged;

  DropMenu({this.hasBorder = true, this.upperText, required this.items, this.onChanged, this.isItemsModel = false, this.hint, this.value});

  @override
  State<DropMenu> createState() => _DropMenuState();
}

class _DropMenuState<T> extends State<DropMenu> {
  dynamic value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.upperText != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(widget.upperText!,style: const TextStyle(fontWeight: FontWeight.w900, color: kPrimaryColor),),
            ),
          Container(
            child: DropdownButtonFormField(
              hint: Text(widget.hint ?? '',style: TextStyle( color:Colors.black45, fontSize: 14),),
              // style: TextStyle( color:Colors.black45, fontSize: 14),
              value: value,
              validator: Validator.dropMenu,
              onChanged: (v){
                if(widget.onChanged == null) return;
                widget.onChanged!(v);
                closeKeyboard();
                setState(() => value = v);
              },
              iconEnabledColor: kPrimaryColor,
              items: widget.items.map((e) => DropdownMenuItem(
                child: Text(widget.isItemsModel ? e.name : e.toString()),
                value: e,
              ),).toList(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                enabledBorder: getBorder(kGreyColor),
                focusedBorder: getBorder(kGreyColor),
                errorBorder: getBorder(Colors.red),
                focusedErrorBorder: getBorder(kPrimaryColor),
                disabledBorder: getBorder(Colors.transparent),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: borderRadius
            ),
          ),
        ],
      ),
    );
  }

  final BorderRadius borderRadius = BorderRadius.circular(10);

  InputBorder getBorder(Color color) {
    if(widget.hasBorder) {
      return OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color),
      );
    } else {
      return UnderlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../constants.dart';
import '../core/validator/validation.dart';

class PinCodeField extends StatelessWidget {
  final void Function(String?)? onSave;
  final void Function(String) onChanged;
  PinCodeField({this.onSave, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5,horizontal: 0),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              validator: Validator.pinCode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: kPrimaryColor,
              backgroundColor: Colors.transparent,
              autoDisposeControllers: true,
              autoDismissKeyboard: true,
              enablePinAutofill: true,
              keyboardType: TextInputType.number,
              textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
              pastedTextStyle: const TextStyle(color: Colors.black),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                selectedColor: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
                activeColor: kPrimaryColor,
                inactiveColor: Colors.grey,
                fieldWidth: 70,
                fieldHeight: 70,
                fieldOuterPadding: EdgeInsets.zero,
              ),
              appContext: context,
              length: 4,
              onSaved: onSave,
              onChanged: onChanged,
              errorTextSpace: 30,
            ),
          ),
        ],
      ),
    );
  }
}
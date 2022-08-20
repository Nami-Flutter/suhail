import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';

showToast(String message,{Color color = kPrimaryColor}){
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
  );
}
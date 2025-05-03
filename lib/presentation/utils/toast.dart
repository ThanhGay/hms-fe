import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> showToast({
  required String msg,
  Color? backgroundColor,
  Color? textColor,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    fontSize: 16,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? Colors.blue[100],
    textColor: textColor ?? Colors.white,
  );
}

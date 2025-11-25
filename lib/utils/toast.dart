import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EasyToast {
  static void show(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color? backgroundColor,
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      backgroundColor: backgroundColor ?? Colors.black87,
      textColor: textColor,
    );
  }
}

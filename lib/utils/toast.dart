import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(var mssg) {
  Fluttertoast.showToast(
      msg: mssg,
      fontSize: 18,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.grey[200],
      textColor: Colors.black);
}

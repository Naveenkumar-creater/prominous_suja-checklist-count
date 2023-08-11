import 'package:flutter/material.dart';

class ErrorShow {
  void showSnackBar(BuildContext? context, String message) {
    if (context != null) {
      final snackBar = SnackBar(
        backgroundColor: Colors.amber[400],
        content:
            Center(child: Text(message, style: TextStyle(color: Colors.black))),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class YRSnackBar {
  YRSnackBar({this.title, this.errorMessage, this.successMessage});
  final String errorMessage;
  final String successMessage;
  final String title;
  void showSnachkBar(BuildContext context) {
    Flushbar(
      padding: EdgeInsets.all(20),
      borderRadius: 8,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundGradient: errorMessage == null
          ? LinearGradient(
              colors: [Colors.green.shade800, Colors.greenAccent.shade700],
              stops: [0.6, 1],
            )
          : LinearGradient(
              colors: [Colors.red.shade800, Colors.redAccent.shade700],
              stops: [0.6, 1],
            ),
      icon: Icon(
        errorMessage == null ? Icons.check_circle : Icons.info_outline,
        size: 28,
        color: errorMessage == null
            ? Colors.greenAccent.shade700
            : Colors.redAccent.shade400,
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: title == null ? null : title,
      message: errorMessage == null ? successMessage : errorMessage,
    )..show(context);
  }
}

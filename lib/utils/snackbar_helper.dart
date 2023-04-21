import 'package:flutter/material.dart';

void showFailureMessage(BuildContext context, {required String message}) {
  final snackbar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showSuccessMessage(BuildContext context, {required String message}) {
  final snackbar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

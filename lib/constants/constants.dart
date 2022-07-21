import 'package:flutter/material.dart';

class Constants {
  static void showActionSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      duration: Duration(milliseconds: 900),
      content: Text('정보를 전부 입력해주세요'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

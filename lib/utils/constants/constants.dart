import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Constants {
  static void showActionSnackbar(BuildContext context, String text) {
    var snackBar = SnackBar(
      duration: const Duration(milliseconds: 900),
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future removeDialog(BuildContext context,
      {required Function() onpressed}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "경고",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            content: Text(
              "노래가 지워집니다. 괜찮습니까?",
            ),
            actions: [
              TextButton(onPressed: onpressed, child: const Text("확인")),
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("취소"))
            ],
          );
        });
  }
}

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': 'ca-app-pub-1039451548608668/5799763922',
        'android': 'ca-app-pub-1039451548608668/4361353898',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

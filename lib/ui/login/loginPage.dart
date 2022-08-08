import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    //load();
    super.initState();
  }

  // void load() async {
  //   try {
  //     await kakaoSignIn.init(Constants.kakaoAppKey);
  //     final hashKey = await kakaoSignIn.hashKey;
  //     print('hashKey: $hashKey');
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> _login() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공 ${token.accessToken}');
    } on PlatformException catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('login')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                _login();
              },
              child: const Text(
                'kakao Login',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

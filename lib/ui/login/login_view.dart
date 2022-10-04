import 'package:daily_music/ui/login/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginViewModel>(builder: (context, provider, child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "로그인이 필요합니다.",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    provider.kakaoLogin();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffFAE54D),
                    ),
                    child: Center(
                      child: Text(
                        '카카오톡으로 로그인',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      provider.kakaoLogout();
                    },
                    child: Text("로그아웃"))
              ],
            ),
          ),
        );
      }),
    );
  }
}

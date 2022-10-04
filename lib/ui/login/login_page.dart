import 'package:daily_music/ui/login/login_view.dart';
import 'package:daily_music/ui/login/login_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: LoginView(),
    );
  }
}

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Widget child;
  const HomeView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}

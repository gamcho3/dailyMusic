// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            currentIndex = value;

            setState(() {});
          },
          selectedIndex: currentIndex,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: '라이브러리',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: '검색',
            ),
          ]),
    );
  }
}

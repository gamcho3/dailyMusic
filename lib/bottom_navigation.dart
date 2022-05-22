import 'package:daliy_music/home/home_screen.dart';
import 'package:daliy_music/search/search.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const HomeScreen(),
        Container(color: Colors.white, child: const Text('list')),
        const SearchPage(),
        Container(color: Colors.white, child: const Text('More'))
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: ((int index) {
          setState(() {
            currentPageIndex = index;
          });
        }),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(LineAwesomeIcons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(LineAwesomeIcons.headphones), label: 'PlayList'),
          NavigationDestination(
              icon: Icon(LineAwesomeIcons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

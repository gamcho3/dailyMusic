import 'package:daliy_music/library/library.dart';
import 'package:daliy_music/playlist/play_list.dart';

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
      appBar: AppBar(
          centerTitle: false,
          titleSpacing: 15,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: const Text(
            "Daily Music",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ]),
      body: <Widget>[
        const LibraryPage(),
        const PlayListPage(),
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
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

import 'package:daliy_music/ui/playlist/playlist_view.dart';
import 'package:daliy_music/ui/setting/more_page.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'ui/library/library_page.dart';
import 'ui/playlist/playlist_page.dart';

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
      // bottomSheet: GestureDetector(
      //   onTap: () {
      //     showModalBottomSheet(
      //         context: context, builder: ((context) => SearchView()));
      //   },
      //   child: Container(
      //       height: 40,
      //       width: double.infinity,
      //       color: Colors.blue,
      //       child: Text('sdfsdf')),
      // ),
      body: <Widget>[
        const LibraryPage(),
        const PlayListPage(),
        const MorePage()
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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

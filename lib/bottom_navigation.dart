import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'ui/library/library_page.dart';

class BottomNavigationPage extends StatefulWidget {
  final int pageIndex;
  const BottomNavigationPage({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late int currentPageIndex;
  @override
  void initState() {
    currentPageIndex = widget.pageIndex;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(currentPageIndex);
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
        // const PlayListPage(),
      ][currentPageIndex],
      bottomNavigationBar: DotNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: [
          DotNavigationBarItem(
              icon: const Icon(LineAwesomeIcons.home),
              selectedColor: Theme.of(context).primaryColor),
          DotNavigationBarItem(
            icon: const Icon(LineAwesomeIcons.headphones),
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}

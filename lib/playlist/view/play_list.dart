import 'package:daliy_music/db/database.dart';
import 'package:daliy_music/playlist/view/playlist_detail_page.dart';
import 'package:daliy_music/playlist/viewModel/playlist.dart';
import 'package:daliy_music/youtube_list/view/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/playList.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   PlayListDatabase.instance.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var list = context.watch<PlayListProvider>().lists;

    return Scaffold(
        appBar: AppBar(title: Text('플레이리스트'), centerTitle: true, actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return PlayListDetailPage();
                })));
              },
              icon: Icon(LineAwesomeIcons.plus))
        ]),
        body:
            // print(provider.lists.length);
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MasonryGridView.count(
            itemCount: list.length,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(list[index].imgUrl),
                        fit: BoxFit.cover)),
                height: (index % 2 + 1) * 200,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Color.fromARGB(255, 39, 39, 39).withOpacity(0.9),
                    height: size.height * 0.1,
                    width: size.width * 0.6,
                    child: Center(
                      child: Text(
                        list[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

import 'package:daliy_music/db/database.dart';

import 'package:daliy_music/views/library/widget/card_detail.dart';
import 'package:daliy_music/views/playlist/playlist_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../view_models/card.dart';
import '../../view_models/playlist.dart';
import '../library/widget/music_card.dart';

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
    var list = context.watch<PlayListProvider>().cards;

    return Scaffold(
        appBar: AppBar(title: Text('플레이리스트'), centerTitle: true, actions: [
          IconButton(
              onPressed: () {
                context.read<AddListProvider>().deletePlayListAll();
                showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => const PlayListDetailPage());
              },
              icon: const Icon(LineAwesomeIcons.plus))
        ]),
        body:
            // print(provider.lists.length);
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: MasonryGridView.count(
            itemCount: list.length,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return CardDetail(item: list[index]);
                    })));
                  },
                  child: MusicCard(
                    index: index,
                    sizeHeight: (index % 2 + 1) * 200,
                    sizeWidth: size.width / 2,
                    items: list[index],
                  )

                  // Container(
                  //   clipBehavior: Clip.antiAlias,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       image: DecorationImage(
                  //           image: AssetImage(list[index].imgUrl),
                  //           fit: BoxFit.cover)),
                  //   height: (index % 2 + 1) * 200,
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Container(
                  //       color: Color.fromARGB(255, 39, 39, 39).withOpacity(0.9),
                  //       height: size.height * 0.05,
                  //       width: size.width * 0.6,
                  //       child: Center(
                  //         child: Text(
                  //           list[index].title,
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  );
            },
          ),
        ));
  }
}

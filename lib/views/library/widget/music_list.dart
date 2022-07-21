import 'package:daliy_music/models/playList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../view_models/playlist.dart';
import 'music_card.dart';

class MusicListView extends StatelessWidget {
  final List<PlayList> items;
  const MusicListView({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var songs = context.watch<PlayListProvider>().playList;
    return SizedBox(
      height: size.height * 0.3,
      child: Builder(builder: (context) {
        if (items.isEmpty) {
          return const Center(
            child: Text("플레이리스트를 만들어주세요"),
          );
        }
        return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MusicCard(
                      sizeWidth: size.width / 2,
                      sizeHeight: size.height * 0.3,
                      items: items[index],
                      index: index,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    items[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text('${songs.length}개')
                ],
              );
            },
            separatorBuilder: ((context, index) {
              return Container(
                width: 15,
              );
            }),
            itemCount: items.length);
      }),
    );
  }
}

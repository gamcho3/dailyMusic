import 'package:daliy_music/youtube_list/models/test_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../youtube_list/models/youtube_popular_model.dart';
import 'music_card.dart';

class MusicListView extends StatelessWidget {
  final List items;
  const MusicListView({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.45,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) {
            return MusicCard(
              size: size,
              items: items,
              index: index,
            );
          },
          separatorBuilder: ((context, index) {
            return Container(
              width: 15,
            );
          }),
          itemCount: items.length),
    );
  }
}

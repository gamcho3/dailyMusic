import 'package:animations/animations.dart';
import 'package:daliy_music/color_schemes.g.dart';
import 'package:daliy_music/library/widget/card_detail.dart';
import 'package:daliy_music/playlist/model/playList.dart';
import 'package:daliy_music/playlist/viewModel/playlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicCard extends StatelessWidget {
  const MusicCard(
      {Key? key,
      required this.items,
      required this.index,
      required this.sizeWidth,
      required this.sizeHeight})
      : super(key: key);

  final double sizeWidth;
  final double sizeHeight;
  final PlayList items;
  final int index;

  @override
  Widget build(BuildContext context) {
    print(sizeHeight);
    return OpenContainer<bool>(
        transitionDuration: const Duration(milliseconds: 300),
        openBuilder: (context, action) {
          return CardDetail(
            item: items,
          );
        },
        closedBuilder: (context, action) {
          return GestureDetector(
            onTap: () {
              action();
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: sizeWidth,
              height: sizeHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(items.imgUrl),
                      fit: sizeHeight == 400 ? BoxFit.fitHeight : BoxFit.fill)),
            ),
          );
        });
  }
}

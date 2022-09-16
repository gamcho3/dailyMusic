import 'dart:io';

import 'package:animations/animations.dart';
import 'package:daliy_music/ui/musicCard/musicCard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../data/models/playList.dart';
import '../../musicCard/musicCard_view.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    Key? key,
    required this.items,
    required this.index,
    required this.sizeWidth,
    required this.sizeHeight,
  }) : super(key: key);

  final double sizeWidth;
  final double sizeHeight;
  final PlayList items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
        transitionDuration: const Duration(milliseconds: 300),
        openBuilder: (context, action) {
          return MusicCardPage(
            item: items,
            index: index,
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
                      image: Platform.isAndroid
                          ? Image.file(File(items.imgUrl)).image
                          : Image.asset(
                              items.imgUrl,
                            ).image,
                      fit: sizeHeight == 400
                          ? BoxFit.fitHeight
                          : BoxFit.fitWidth)),
              child: LayoutBuilder(
                builder: ((context, constraints) {
                  return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: constraints.maxHeight / 2.8,
                        width: constraints.maxWidth,
                        color: Color(0xff292929),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          items.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        items.content,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SvgPicture.asset(
                                  'images/play.svg',
                                  height: constraints.maxWidth / 5,
                                )
                              ]),
                        ),
                      ));
                }),
              ),
            ),
          );
        });
  }
}

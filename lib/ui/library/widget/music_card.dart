import 'dart:io';

import 'package:animations/animations.dart';
import 'package:daily_music/ui/musicCard/musicCard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/playList.dart';
import '../../musicCard/musicCard_view.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    Key? key,
    required this.items,
    required this.index,
  }) : super(key: key);

  final PlayList items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed('musicCard',
            params: {'index': index.toString()}, extra: items);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: LayoutBuilder(
            builder: ((context, constraints) {
              return Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Image.file(
                        File(items.imgUrl),
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      )),
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: constraints.maxWidth,
                          color: Color(0xff292929),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(items.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                        Text(
                                          items.content,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        )
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'images/music.png',
                                    height: constraints.maxWidth / 7,
                                  )
                                ]),
                          ),
                        )),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

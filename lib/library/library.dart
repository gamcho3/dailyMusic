import 'package:daliy_music/library/widget/main_title.dart';
import 'package:daliy_music/library/widget/music_list.dart';
import 'package:daliy_music/youtube_list/view_models/card.dart';

import 'package:daliy_music/youtube_list/view_models/youtubeProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<CardProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTitle(
                  title: "인기 추천곡",
                ),
                MusicListView(
                  items: provider.cards,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

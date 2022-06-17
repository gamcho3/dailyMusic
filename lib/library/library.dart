import 'dart:io';

import 'package:daliy_music/player/player.dart';
import 'package:daliy_music/youtube_list/view_models/youtubeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      body: Consumer<YoutubeProvider>(builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("실시간 상승 한국 음악"),
            SizedBox(
              height: 250,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 250,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(
                              image: AssetImage('images/unsplash.jpg'))),
                    );
                  },
                  separatorBuilder: ((context, index) {
                    return Container();
                  }),
                  itemCount: 5),
            )
          ],
        );
      }),
    );
  }
}

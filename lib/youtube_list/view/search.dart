import 'dart:async';
import 'dart:io';
import 'package:daliy_music/db/database.dart';
import 'package:daliy_music/player/player.dart';
import 'package:daliy_music/youtube_list/view/music_list.dart';
import 'package:daliy_music/youtube_list/view_models/youtubeProvider.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../models/youtube_list_models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _debounce;
  final _textController = TextEditingController();
  FocusNode _focus = FocusNode();
  bool isFocus = true;

  @override
  void initState() {
    super.initState();
  }

  _onsearchChanged(String query, YoutubeProvider provider) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    print(query);
    _debounce = Timer(Duration(milliseconds: 500), () {
      provider.getYoutubeList(query);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<YoutubeProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(LineAwesomeIcons.arrow_left)),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          autofocus: true,
                          focusNode: _focus,
                          controller: _textController,
                          onSubmitted: (value) {
                            provider.getYoutubeList(value);
                            isFocus = false;
                            setState(() {});
                          },
                          onChanged: (value) {
                            // _onsearchChanged(value, provider);
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffixIcon: _textController.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: (() {
                                        _textController.clear();
                                      }),
                                      icon: const Icon(LineAwesomeIcons.times)),
                              hintText: "노래,아티스트 검색"),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // if (isFocus)
                  //   Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [Text("최근 검색어")]),
                  if (provider.loading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (provider.musicList.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: ((context, index) {
                            return const SizedBox(
                              height: 13,
                            );
                          }),
                          itemCount: provider.musicList.length,
                          itemBuilder: ((context, index) {
                            return MusicList(item: provider.musicList[index]);
                          })),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';
import 'package:daliy_music/ui/playlist/makeCard/make_playlist_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import 'widgets/music_list.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounce;
  final _textController = TextEditingController();
  FocusNode _focus = FocusNode();
  bool isFocus = true;

  @override
  void initState() {
    super.initState();
  }

  // _onsearchChanged(String query, YoutubeProvider provider) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   print(query);
  //   _debounce = Timer(Duration(milliseconds: 500), () {
  //     provider.getYoutubeList(query);
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<MakePlayListViewModel>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(20),
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
            );
          },
        ),
      ),
    );
  }
}

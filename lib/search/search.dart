import 'package:daliy_music/services/youtube.dart';
import 'package:daliy_music/viewModel/youtubeProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/connectivityService.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  FocusNode _focus = FocusNode();
  //String keyword = '';

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    // context.read<YoutubeProvider>().clearKeyword();
    // asyncMethod();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }
  // void asyncMethod() async {
  //   var _youtubeList = YoutubeServices();
  //   var value = await _youtubeList.getYoutubeData(keyword: 'bts');
  //   print(value);
  // }

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
                  TextField(
                    autofocus: true,
                    focusNode: _focus,
                    controller: _textController,
                    onSubmitted: (value) {
                      print(value);
                      provider.getList();
                    },
                    onChanged: (value) {
                      provider.getKeyword(value);
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        suffixIcon: provider.keyword.isEmpty
                            ? null
                            : IconButton(
                                onPressed: (() {
                                  provider.clearKeyword();
                                  _textController.clear();
                                }),
                                icon: const Icon(LineAwesomeIcons.times)),
                        hintText: "노래,아티스트 검색"),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (provider.musicList.isEmpty)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (provider.musicList.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: ((context, index) {
                            return SizedBox(
                              height: 13,
                            );
                          }),
                          itemCount: provider.musicList.length,
                          itemBuilder: ((context, index) {
                            return MusicList(
                              item: provider.musicList[index],
                            );
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

class MusicList extends StatelessWidget {
  final Item item;
  const MusicList({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          width: 70,
          height: 70,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 1.0, spreadRadius: 1.0)
          ], borderRadius: BorderRadius.circular(15)),
          child: Image.network(
            item.snippet.thumbnails.medium.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.snippet.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              item.snippet.channelTitle,
              maxLines: 2,
            ),
            //Text(state.items[1].snippet.description)
          ],
        ),
      )
    ]);
  }
}

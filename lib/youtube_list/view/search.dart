import 'dart:io';

import 'package:daliy_music/youtube_list/view_models/youtubeProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/youtube_list_models.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  FocusNode _focus = FocusNode();
  bool isFocus = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
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
                  TextField(
                    autofocus: true,
                    focusNode: _focus,
                    controller: _textController,
                    onSubmitted: (value) {
                      provider.getYoutubeList(value);
                      isFocus = false;
                      setState(() {});
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
                  const SizedBox(
                    height: 15,
                  ),
                  if (isFocus)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("최근 검색어")]),
                  if (provider.loading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (!isFocus && provider.musicList.isNotEmpty)
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

class MusicList extends StatefulWidget {
  final Item item;

  const MusicList({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  void initState() {
    super.initState();
  }

  downloadYoutube(link) async {
    var yt = YoutubeExplode();
    //Directory('downloads').createSync();
    // Get video metadata.
    var video = await yt.videos.get(link);
    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(link);
    var streams = manifest.audioOnly;
    // Get the audio track with the highest bitrate.
    var audio = streams.first;
    var audioStream = yt.videos.streamsClient.get(audio);
    print(streams.whereType());
    var fileName = '${video.title}.${audio.container.name}'
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', '');
    var file = File('downloads/$fileName');
    // Delete the file if exists.
    if (file.existsSync()) {
      file.deleteSync();
    }
    print(file.path);
    Share.shareFiles([file.path]);
    // Open the file in writeAppend.
    // var output = file.openWrite(mode: FileMode.writeOnlyAppend);

    // // Track the file download status.
    // var len = audio.size.totalBytes;
    // var count = 0;

    // // Create the message and set the cursor position.
    // var msg = 'Downloading ${video.title}.${audio.container.name}';
    // stdout.writeln(msg);

    // // Listen for data received.

    // await for (final data in audioStream) {
    //   // Write to file.
    //   output.add(data);
    // }
    // await output.close();
    // yt.close();
    // exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        downloadYoutube(widget.item.id.videoId);
      },
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
              widget.item.snippet.thumbnails.medium.url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.item.snippet.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.item.snippet.channelTitle,
                maxLines: 2,
              ),
              //Text(state.items[1].snippet.description)
            ],
          ),
        )
      ]),
    );
  }
}
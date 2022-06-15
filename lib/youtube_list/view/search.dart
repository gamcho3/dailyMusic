import 'dart:async';
import 'dart:io';
import 'package:daliy_music/player/player.dart';
import 'package:daliy_music/youtube_list/view_models/youtubeProvider.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
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
                  TextField(
                    autofocus: true,
                    focusNode: _focus,
                    controller: _textController,
                    onSubmitted: (value) {
                      provider.getYoutubeList(value);
                      isFocus = false;
                      setState(() {});
                    },
                    onChanged: (value) {
                      _onsearchChanged(value, provider);
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

  Future<File> downloadYoutube(link) async {
    var yt = YoutubeExplode();
    //Directory('downloads').createSync();
    // Get video metadata.
    var video = await yt.videos.get(link);
    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(link);
    var audio = manifest.videoOnly.last;
    // Build the directory.
    var dir = await getApplicationDocumentsDirectory();
    var filePath =
        path.join(dir.uri.toFilePath(), '${video.id}.${audio.container.name}');

    // var fileName = '${video.title}.${audio.container.name}'
    //     .replaceAll(r'\', '')
    //     .replaceAll('/', '')
    //     .replaceAll('*', '')
    //     .replaceAll('?', '')
    //     .replaceAll('"', '')
    //     .replaceAll('<', '')
    //     .replaceAll('>', '')
    //     .replaceAll('|', '');
    // var file = File('downloads/$fileName');
    // // Delete the file if exists.
    // if (file.existsSync()) {
    //   file.deleteSync();
    // }
    //Open the file to write.
    var file = File(filePath);
    var fileStream = file.openWrite();

    await yt.videos.streamsClient.get(audio).pipe(fileStream);
    // Create the message and set the cursor position.

    await fileStream.flush();
    await fileStream.close();
    print(filePath);
    //Share.shareFiles([file.path]);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        downloadYoutube(widget.item.id.videoId).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PlayerPage(
              videoFile: value,
            );
          }));
        });
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

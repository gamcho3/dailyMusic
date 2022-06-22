import 'dart:io';
import 'package:daliy_music/player/player.dart';
import 'package:daliy_music/youtube_list/view_models/card.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class CardDetail extends StatefulWidget {
  final Map item;
  const CardDetail({Key? key, required this.item}) : super(key: key);

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    bool loading = context.watch<CardProvider>().isLoading;
    Future<File> downloadYoutube(link) async {
      var yt = YoutubeExplode();
      //Directory('downloads').createSync();
      // Get video metadata.
      var video = await yt.videos.get(link);
      // Get the video manifest.
      var manifest = await yt.videos.streamsClient.getManifest(link);

      var audio = manifest.audio[1];
      // Build the directory.
      var dir = await getApplicationDocumentsDirectory();
      var filePath = path.join(
          dir.uri.toFilePath(), '${video.id}.${audio.container.name}');

      var file = File(filePath);
      var fileStream = file.openWrite();

      await yt.videos.streamsClient.get(audio).pipe(fileStream);
      // Create the message and set the cursor position.

      await fileStream.flush();
      await fileStream.close();
      return file;
    }

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                    background: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          widget.item['image']["hot"],
                          fit: BoxFit.fill,
                        ))),
              ),
              SliverFillRemaining(
                // 탭바 뷰 내부에는 스크롤이 되는 위젯이 들어옴.
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () async {
                            context.read<CardProvider>().updateLoading(true);
                            List<File> list = [];
                            for (var i = 0;
                                i < widget.item['musicList'].length;
                                i++) {
                              list.add(
                                await downloadYoutube(
                                  widget.item['musicList'][i]['musicCode'],
                                ),
                              );
                            }
                            // ignore: use_build_context_synchronously
                            context.read<CardProvider>().updateLoading(false);
                            print(list.length);
                            // ignore: use_build_context_synchronously
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return PlayerPage(
                                videoFiles: list,
                                items: widget.item['musicList'],
                              );
                            })));
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            ),
                          )),
                    ),
                    for (var i = 0; i < widget.item['musicList'].length; i++)
                      MusicTile(
                        item: widget.item,
                        index: i,
                      ),
                  ]),
                ),
              )
            ],
          ),
          if (loading)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "노래 준비중...",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              )),
            )
        ],
      ),
    );
  }
}

class MusicTile extends StatelessWidget {
  const MusicTile({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  final int index;
  final Map item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 60,
        height: 50,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            item['musicList'][index]['thumbnail'],
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(item['musicList'][index]['title']),
      subtitle: Text(item['musicList'][index]['singer']),
    );
  }
}

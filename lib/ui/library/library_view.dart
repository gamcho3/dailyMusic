import 'dart:io';

import 'package:daily_music/data/models/playList.dart';
import 'package:daily_music/ui/library/widget/music_card.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../makeCard/make_playlist_viewModel.dart';
import 'library_viewModel.dart';
import 'widget/main_title.dart';
import 'package:path/path.dart' as path;
class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(LineAwesomeIcons.plus),
        onPressed: () {
          context.read<LibraryViewModel>().clearTempList();
          context.push('/library/makeList');
        },
      ),
      body: Consumer<LibraryViewModel>(builder: (context, provider, child) {
        var playList = provider.cards;
        print('playlist ${playList?.length}');
        return RefreshIndicator(
          onRefresh: () => provider.getCards(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                titleSpacing: 15,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () {
                        context.pushNamed('login');
                      },
                      icon: const Icon(LineAwesomeIcons.user_circle))
                ],
                title: const Text(
                  "오늘의 음악",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              if (playList != null) SliverPlayList(playList: playList),
              if (playList != null && playList.isEmpty)
                SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/music.png',
                        width: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "플레이리스트를 만들어 주세요.",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ElevatedButton(onPressed: ()async {
                        var yt = YoutubeExplode();
                        //Directory('downloads').createSync();
                        // Get video metadata.
                        var video = await yt.videos.get('Dpp1sIL1m5Q');
                        // Get the video manifest.
                        var manifest = await yt.videos.streamsClient.getManifest('Dpp1sIL1m5Q');
                        final streamInfo =
                        manifest.audioOnly.withHighestBitrate();

                        var audioStream = yt.videos.streamsClient.get(streamInfo);
                        // Build the directory.
                        var dir = await getApplicationDocumentsDirectory();
                        var filePath =
                        path.join(dir.uri.toFilePath(), '${video.id}.${streamInfo.container.name}');

                        //Open the file to write.
                        var file = File(filePath);
                        var fileStream = file.openWrite();


                        await for (final data in audioStream) {

                          fileStream.add(data);
                        }
                        await yt.videos.streamsClient.get(streamInfo).pipe(fileStream);
                        // Create the message and set the cursor position.

                        await fileStream.flush();
                        await fileStream.close();

                       final conversion = await FFmpegKit.execute("-i ${file.path} -vn -ab 128k -ar 44100 -y ${file.path}.mp3");
                       final output = conversion.getArguments();
                        print(output);

                      }, child: Text("test"))
                    ],
                  ),
                )
            ],
          ),
        );
      }),
    );
  }
}

class SliverPlayList extends StatefulWidget {
  const SliverPlayList({
    Key? key,
    required this.playList,
  }) : super(key: key);

  final List<PlayList> playList;

  @override
  State<SliverPlayList> createState() => _SliverPlayListState();
}

class _SliverPlayListState extends State<SliverPlayList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(childCount: widget.playList.length,
            (context, index) {
          return MusicCard(
            items: widget.playList[index],
            index: index,
          );
        }),
        itemExtent: 280);
  }
}

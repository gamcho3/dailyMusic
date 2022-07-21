import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:daliy_music/models/music_files.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:marquee/marquee.dart';

class PlayerPage extends StatefulWidget {
  final List<MusicFiles> items;

  const PlayerPage({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  //late BetterPlayerController _betterPlayerController;
  bool isPause = false;
  double rating = 0.5;
  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
      GlobalKey();
  late BetterPlayerConfiguration _betterPlayerConfiguration;
  late BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;
  final List<BetterPlayerDataSource> _dataSourceList = [];
  @override
  void initState() {
    _betterPlayerConfiguration = const BetterPlayerConfiguration(
      autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      handleLifecycle: false,
    );
    _betterPlayerPlaylistConfiguration =
        const BetterPlayerPlaylistConfiguration(
      loopVideos: true,
      nextVideoDelay: Duration(seconds: 3),
    );
    // _betterPlayerController =
    //     BetterPlayerController(_betterPlayerConfiguration);
    // _setupDataSource();
    super.initState();
  }

  // void _setupDataSource() async {
  //   BetterPlayerDataSource dataSource = BetterPlayerDataSource(
  //     BetterPlayerDataSourceType.file,
  //     widget.videoFile!.path,
  //     notificationConfiguration: BetterPlayerNotificationConfiguration(
  //       showNotification: true,
  //       title: "dff",
  //       author: "Some author",
  //       activityName: "MainActivity",
  //     ),
  //   );
  //   _betterPlayerController.setupDataSource(dataSource);
  // }

  List<BetterPlayerDataSource> createDataSet() {
    for (var i = 0; i < widget.items.length; i++) {
      _dataSourceList.add(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.file,
          widget.items[i].musicFilePath,
          notificationConfiguration: BetterPlayerNotificationConfiguration(
              showNotification: true,
              title: widget.items[i].title,
              imageUrl: widget.items[i].imgUrl),
        ),
      );
    }
    return _dataSourceList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1,
              child: BetterPlayerPlaylist(
                key: _betterPlayerPlaylistStateKey,
                betterPlayerConfiguration: _betterPlayerConfiguration,
                betterPlayerPlaylistConfiguration:
                    _betterPlayerPlaylistConfiguration,
                betterPlayerDataSourceList: createDataSet(),
              ),
            ),
          ),
          // AspectRatio(
          //   aspectRatio: 16 / 9,
          //   child: BetterPlayer(controller: _betterPlayerController),
          // ),
          SizedBox(
            height: 50,
            child: Marquee(
              text: widget
                  .items[
                      _betterPlayerPlaylistController?.currentDataSourceIndex ??
                          0]
                  .title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              blankSpace: 20.0,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              velocity: 60.0,
              startPadding: 10.0,
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color:
                      _betterPlayerPlaylistController?.currentDataSourceIndex ==
                              0
                          ? Colors.grey
                          : Colors.black,
                  iconSize: 50,
                  onPressed: _betterPlayerPlaylistController
                              ?.currentDataSourceIndex ==
                          0
                      ? null
                      : () {
                          _betterPlayerPlaylistController?.setupDataSource(0);
                          setState(() {});
                        },
                  icon: const Icon(
                    LineAwesomeIcons.reply,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (isPause) {
                      _betterPlayerPlaylistController?.betterPlayerController!
                          .play();
                    } else {
                      _betterPlayerPlaylistController?.betterPlayerController!
                          .pause();
                    }

                    setState(() {
                      isPause = !isPause;
                    });
                  },
                  child: Icon(
                    isPause
                        ? LineAwesomeIcons.play_circle
                        : LineAwesomeIcons.pause_circle,
                    size: 100,
                  ),
                ),
                IconButton(
                  color:
                      _betterPlayerPlaylistController?.currentDataSourceIndex ==
                              widget.items.length - 1
                          ? Colors.grey
                          : Colors.black,
                  iconSize: 50,
                  onPressed:
                      _betterPlayerPlaylistController?.currentDataSourceIndex ==
                              widget.items.length - 1
                          ? null
                          : () {
                              _betterPlayerPlaylistController
                                  ?.betterPlayerController
                                  ?.playNextVideo();
                              setState(() {});
                            },
                  icon: const Icon(
                    LineAwesomeIcons.step_forward,
                  ),
                ),
              ],
            ),
          ),
          Slider(
              value: rating,
              onChanged: (newRating) {
                setState(() {
                  rating = newRating;
                  _betterPlayerPlaylistController?.betterPlayerController!
                      .setVolume(rating);
                });
              })
          // ElevatedButton(
          //   onPressed: () {
          //     var list = [
          //       BetterPlayerDataSource(
          //         BetterPlayerDataSourceType.network,
          //         Constants.bugBuckBunnyVideoUrl,
          //         placeholder: Image.network(
          //           Constants.catImageUrl,
          //           fit: BoxFit.cover,
          //         ),
          //       )
          //     ];
          //     _betterPlayerPlaylistController?.setupDataSourceList(list);
          //   },
          //   child: Text("Setup new data source list"),
          // ),
        ],
      ),
    );
  }

  BetterPlayerPlaylistController? get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey
          .currentState?.betterPlayerPlaylistController;
}

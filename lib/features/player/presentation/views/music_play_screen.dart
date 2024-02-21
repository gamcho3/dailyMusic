import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:daily_music/gen/assets.gen.dart';
import 'package:daily_music/notifiers/play_button_notifier.dart';
import 'package:daily_music/notifiers/progress_notifier.dart';
import 'package:daily_music/utils/services/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 음악플레이 화면
class MusicPlayScreen extends StatelessWidget {
  const MusicPlayScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final pageManager = ref.watch(pageManagerProvider);
                  return ValueListenableBuilder<String>(
                    valueListenable: pageManager.currentSongAlbumNotifier,
                    builder: (_, value, __) {
                      if (value == '') {
                        return const CircularProgressIndicator();
                      }
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(value), fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final pageManager = ref.watch(pageManagerProvider);
                  return Column(
                    children: [
                      Column(
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable:
                                pageManager.currentSongTitleNotifier,
                            builder: (_, value, __) {
                              return Text(
                                value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              );
                            },
                          ),
                          ValueListenableBuilder<String>(
                            valueListenable:
                                pageManager.currentSongArtistNotifier,
                            builder: (_, value, __) {
                              return Text(
                                value,
                                style: TextStyle(fontSize: 18),
                              );
                            },
                          )
                        ],
                      ),
                      Consumer(
                        builder: (context, ref, _) {
                          final pageManager = ref.watch(pageManagerProvider);
                          return ValueListenableBuilder<ProgressBarState>(
                            valueListenable: pageManager.progressNotifier,
                            builder: (_, value, __) {
                              return ProgressBar(
                                progress: value.current,
                                buffered: value.buffered,
                                total: value.total,
                                onSeek: pageManager.seek,
                              );
                            },
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // IconButton(onPressed: () {}, icon: Icon(Icons.repeat)),
                          IconButton(
                            icon: const Icon(
                              Icons.skip_previous,
                              size: 50,
                            ),
                            onPressed: () {},
                          ),
                          Consumer(
                            builder: (context, ref, _) {
                              final pageManager =
                                  ref.watch(pageManagerProvider);
                              return ValueListenableBuilder(
                                valueListenable: pageManager.playButtonNotifier,
                                builder: (_, value, __) {
                                  switch (value) {
                                    case ButtonState.loading:
                                      return Container(
                                        margin: const EdgeInsets.all(8.0),
                                        width: 32.0,
                                        height: 32.0,
                                        child:
                                            const CircularProgressIndicator(),
                                      );
                                    case ButtonState.paused:
                                      return IconButton(
                                        icon: const Icon(Icons.play_arrow),
                                        iconSize: 32.0,
                                        onPressed: pageManager.play,
                                      );
                                    case ButtonState.playing:
                                      return IconButton(
                                        icon: const Icon(Icons.pause),
                                        iconSize: 32.0,
                                        onPressed: pageManager.pause,
                                      );
                                  }
                                },
                              );
                            },
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.skip_next,
                                size: 50,
                              ))
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:daily_music/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 음악플레이 화면
class MusicPlayScreen extends StatelessWidget {
  const MusicPlayScreen({super.key});

  static String get name => 'player';

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.down,
        onDismissed: (direction) => context.pop(),
        background: const ColoredBox(color: Colors.transparent),
        key: Key('playScreen'),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: Assets.images.album.provider(),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Isolation",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "John Lennon",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              ProgressBar(
                progress: Duration(milliseconds: 1000),
                total: Duration(milliseconds: 5000),
                onSeek: (value) {
                  print(value);
                },
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.repeat)),
                  IconButton(
                    icon: const Icon(Icons.skip_previous),
                    onPressed: () {},
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow))
                ],
              )
            ]),
          ),
        ));
  }
}

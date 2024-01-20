import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:daily_music/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 음악플레이 화면
class MusicPlayScreen extends StatelessWidget {
  const MusicPlayScreen({super.key});

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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: Assets.images.album.provider(), fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "Isolation",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  final File videoFile;
  const PlayerPage({
    Key? key,
    required this.videoFile,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      handleLifecycle: true,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _setupDataSource();
    super.initState();
  }

  void _setupDataSource() async {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      widget.videoFile.path,
      notificationConfiguration: const BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: "Elephant dream",
        author: "Some author",
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg",
      ),
    );
    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example player"),
      ),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(
          controller: _betterPlayerController,
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    //final args = ModalRoute.of(context)!.settings.arguments as String;
    _controller = YoutubePlayerController(
        initialVideoId: 'YQHsXMglC9A',
        params: const YoutubePlayerParams(
          playlist: ['YQHsXMglC9A'],
          startAt: Duration(minutes: 1, seconds: 36),
          autoPlay: true,
          desktopMode: false,
          privacyEnhanced: true,
          useHybridComposition: true,
        ));

    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();

    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              children: [
                Stack(
                  children: [
                    player,
                    Positioned.fill(
                      child: YoutubeValueBuilder(
                        controller: _controller,
                        builder: (context, value) {
                          return AnimatedCrossFade(
                            firstChild: const SizedBox.shrink(),
                            secondChild: Material(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      YoutubePlayerController.getThumbnail(
                                        videoId:
                                            _controller.params.playlist.first,
                                        quality: ThumbnailQuality.medium,
                                      ),
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            crossFadeState: value.isReady
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

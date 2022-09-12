import 'package:daliy_music/ui/library/youtube_player/youtube_player_view.dart';
import 'package:daliy_music/ui/library/youtube_player/youtube_player_viewModel.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class YoutubePlayerPage extends StatelessWidget {
  final String videoId;
  const YoutubePlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => YoutubePlayerViewModel(),
      child: YoutubePlayerView(
        videoId: videoId,
      ),
    );
  }
}

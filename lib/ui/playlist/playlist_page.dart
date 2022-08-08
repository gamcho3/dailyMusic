import 'package:daliy_music/ui/playlist/playlist_view.dart';
import 'package:daliy_music/ui/playlist/playlist_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayListPage extends StatelessWidget {
  const PlayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayListViewModel(),
      child: const PlayListView(),
    );
  }
}

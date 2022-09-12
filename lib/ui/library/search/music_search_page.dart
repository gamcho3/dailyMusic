import 'package:daliy_music/ui/library/search/music_search_view.dart';
import 'package:daliy_music/ui/library/search/music_search_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MusicSearchPage extends StatelessWidget {
  final String keyword;
  const MusicSearchPage({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MusicSearchViewModel(keyword),
      child: const MusicSearchView(),
    );
  }
}

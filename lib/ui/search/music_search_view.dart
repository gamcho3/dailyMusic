import 'package:daliy_music/ui/search/music_search_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicSearchView extends StatelessWidget {
  const MusicSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicSearchViewModel>(builder: (context, provider, child) {
      var result = provider.searchResult;

      return Scaffold(
        body: Container(),
      );
    });
  }
}

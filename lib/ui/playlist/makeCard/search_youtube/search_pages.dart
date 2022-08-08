import 'package:daliy_music/ui/playlist/makeCard/make_playlist_viewModel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MakePlayListViewModel(),
      child: const SearchView(),
    );
  }
}

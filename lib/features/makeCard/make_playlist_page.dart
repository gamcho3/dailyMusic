import 'package:daily_music/features/library/library_viewModel.dart';
import 'package:daily_music/features/makeCard/make_playlist_viewModel.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'make_playlist_view.dart';

class MakePlayListPage extends StatelessWidget {
  const MakePlayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MakePlayListViewModel()),
      ChangeNotifierProvider(create: (_) => LibraryViewModel()),
    ], child: const MakePlayListView());
  }
}

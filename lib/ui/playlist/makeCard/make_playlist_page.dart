import 'package:daliy_music/ui/playlist/makeCard/make_playlist_view.dart';
import 'package:daliy_music/ui/playlist/makeCard/make_playlist_viewModel.dart';
import 'package:daliy_music/ui/playlist/playlist_viewModel.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../library/library_viewModel.dart';

class MakePlayListPage extends StatelessWidget {
  const MakePlayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MakePlayListViewModel()),
      ChangeNotifierProvider(create: (_) => PlayListViewModel())
    ], child: const MakePlayListView());
  }
}

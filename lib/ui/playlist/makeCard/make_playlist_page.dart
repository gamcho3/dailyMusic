import 'package:daliy_music/ui/playlist/makeCard/make_playlist_view.dart';
import 'package:daliy_music/ui/playlist/makeCard/make_playlist_viewModel.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MakePlayListPage extends StatelessWidget {
  const MakePlayListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MakePlayListViewModel(),
      child: const MakePlayListView(),
    );
  }
}

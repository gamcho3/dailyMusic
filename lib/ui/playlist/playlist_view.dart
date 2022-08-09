import 'package:daliy_music/ui/playlist/makeCard/make_playlist_page.dart';
import 'package:daliy_music/ui/playlist/playlist_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../library/widget/music_card.dart';

class PlayListView extends StatefulWidget {
  const PlayListView({Key? key}) : super(key: key);

  @override
  State<PlayListView> createState() => _PlayListViewState();
}

class _PlayListViewState extends State<PlayListView> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   LocalDataSource.instance.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar:
            AppBar(title: const Text('플레이리스트'), centerTitle: true, actions: [
          IconButton(
              onPressed: () {
                // context.read<SearchViewModel>().deleteTempPlayListAll();
                showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => const MakePlayListPage());
              },
              icon: const Icon(LineAwesomeIcons.plus))
        ]),
        body:
            // print(provider.lists.length);
            Consumer<PlayListViewModel>(builder: (context, provider, child) {
          var list = provider.cards;
          if (list.isEmpty) {
            return const Center(
              child: Text("리스트가 없습니다."),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: MasonryGridView.count(
                itemCount: list.length,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  return MusicCard(
                    index: index,
                    sizeHeight: (index % 2 + 1) * 200,
                    sizeWidth: size.width / 2,
                    items: list[index],
                  );
                },
              ),
            );
          }
        }));
  }
}

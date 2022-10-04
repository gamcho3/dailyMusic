import 'package:daily_music/data/models/playList.dart';
import 'package:daily_music/ui/library/widget/music_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'library_viewModel.dart';
import 'widget/main_title.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(LineAwesomeIcons.plus),
        onPressed: () {
          context.read<LibraryViewModel>().clearTempList();
          context.push('/library/makeList');
        },
      ),
      body: Consumer<LibraryViewModel>(builder: (context, provider, child) {
        var playList = provider.cards;
        print('playlist ${playList?.length}');
        return RefreshIndicator(
          onRefresh: () => provider.getCards(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                titleSpacing: 15,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () {
                        context.pushNamed('login');
                      },
                      icon: const Icon(LineAwesomeIcons.user_circle))
                ],
                title: const Text(
                  "오늘의 음악",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              if (playList != null) SliverPlayList(playList: playList),
              if (playList != null && playList.isEmpty)
                SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/music.png',
                        width: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "플레이리스트를 만들어 주세요.",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      }),
    );
  }
}

class SliverPlayList extends StatefulWidget {
  const SliverPlayList({
    Key? key,
    required this.playList,
  }) : super(key: key);

  final List<PlayList> playList;

  @override
  State<SliverPlayList> createState() => _SliverPlayListState();
}

class _SliverPlayListState extends State<SliverPlayList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(childCount: widget.playList.length,
            (context, index) {
          return MusicCard(
            items: widget.playList[index],
            index: index,
          );
        }),
        itemExtent: 280);
  }
}

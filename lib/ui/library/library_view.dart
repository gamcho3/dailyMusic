import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'library_viewModel.dart';
import 'widget/main_title.dart';
import 'widget/music_list.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(LineAwesomeIcons.plus),
        onPressed: () {
          context.go('/library/makeList');
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 15,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "오늘의 음악",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Consumer<LibraryViewModel>(builder: (context, provider, child) {
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainTitle(
                    title: "나의 플레이리스트",
                  ),
                  if (provider.cards != null)
                    MusicListView(
                      items: provider.cards!,
                    )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'library_viewModel.dart';
import 'widget/main_title.dart';
import 'widget/music_list.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 15,
        elevation: 0,
        title: const Text(
          "Daily Music",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Consumer<LibraryViewModel>(builder: (context, provider, child) {
        return CustomScrollView(
          slivers: [
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

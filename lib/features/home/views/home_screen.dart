import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:daily_music/features/common/domains/music_model.dart';
import 'package:daily_music/features/home/providers/music_list_provider.dart';

import 'package:daily_music/features/player/presentation/views/music_play_screen.dart';
import 'package:daily_music/routes/routes.dart';
import 'package:daily_music/utils/services/page_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String get name => 'home';

  @override
  Widget build(BuildContext context) {
    final drawerKey = GlobalKey<ScaffoldState>();

    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        key: drawerKey,
        drawer: Drawer(
          child: ListView(
            children: [DrawerHeader(child: Text("Drawer Header")), ListTile()],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            '오늘의 음악',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              drawerKey.currentState?.openDrawer();
            },
          ),
          bottom: const TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              tabs: [
                Tab(
                  text: '최근파일',
                ),
                Tab(
                  text: '저장소',
                )
              ]),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       // context.goNamed(MusicPlayScreen.name);
                //     },
                //     child: Text("플레이어 버튼")),
                Center(child: Text("준비중입니다.")),
              ],
            ),
            Consumer(
              builder: (context, ref, _) {
                final state = ref.watch(musicsProvider);
                final audioManager = ref.watch(pageManagerProvider);

                return switch (state) {
                  MusicsLoading() =>
                    const Center(child: CircularProgressIndicator()),
                  MusicsSuccess() => ListView.builder(
                      itemCount: state.list!.length,
                      itemBuilder: (context, index) {
                        final music = state.list![index];
                        return ListTile(
                          onTap: () {
                            MusicPlayerRoute().go(context);
                            audioManager.playMusic(music.id);
                          },
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                music.albumArt,
                                fit: BoxFit.cover,
                              )),
                          title: Text(music.title),
                          subtitle: Text(music.subtitle),
                        );
                      }),
                  _ => Container()
                };
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              CreateMusicRoute().go(context);
            },
            label: const Row(
              children: [Icon(Icons.music_note), Text("추가하기")],
            )),
        // bottomNavigationBar: BottomAppBar(
        //   child: Row(
        //     children: [
        //       IconButton(
        //           onPressed: () async {
        //             FilePickerResult? result =
        //                 await FilePicker.platform.pickFiles();

        //             if (result != null) {
        //               File file = File(result.files.single.path!);
        //             } else {
        //               // User canceled the picker
        //             }
        //           },
        //           icon: Icon(Icons.file_copy))
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

import 'package:daliy_music/API/API_list.dart';

import 'package:daliy_music/models/playList.dart';

import 'package:daliy_music/view_models/playlist.dart';
import 'package:daliy_music/views/library/widget/main_title.dart';
import 'package:daliy_music/views/library/widget/music_list.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

import '../../models/weather.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      obtainWeather();
    });
    super.initState();
  }

  void obtainWeather() async {
    var result = await LocationAPI.determinePosition();
    if (result != null) {
      WeatherModel data =
          await WeatherAPI.getWeather(result.latitude, result.longitude);
      print(data.main.temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          titleSpacing: 15,
          elevation: 0,
          title: const Text(
            "Daily Music",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ]),
      body: Consumer<PlayListProvider>(builder: (context, provider, child) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainTitle(
                    title: "나의 플레이리스트",
                  ),
                  MusicListView(
                    items: provider.cards,
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
import 'package:daliy_music/library/widget/main_title.dart';
import 'package:daliy_music/library/widget/music_list.dart';
import 'package:daliy_music/services/weather.dart';
import 'package:daliy_music/youtube_list/view_models/card.dart';

import 'package:daliy_music/youtube_list/view_models/youtubeProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

import '../API/API_list.dart';

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
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: const Text(
            "Daily Music",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
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
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ]),
      body: Consumer<CardProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTitle(
                  title: "인기 추천곡",
                ),
                MusicListView(
                  items: provider.cards,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

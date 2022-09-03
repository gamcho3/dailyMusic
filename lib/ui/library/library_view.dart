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
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 15,
        elevation: 0,
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
                [
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: TextFormField(
                  //     onFieldSubmitted: (value) {
                  //       if (value.isEmpty) {
                  //       } else {
                  //         context.go('/search?query=$value');
                  //       }
                  //     },
                  //     decoration: InputDecoration(
                  //       isDense: true,
                  //       filled: true,
                  //       fillColor:
                  //           Theme.of(context).backgroundColor.withOpacity(0.3),
                  //       hintText: "노래 검색하기",
                  //       prefixIcon: Icon(
                  //         LineAwesomeIcons.search,
                  //         color: Colors.grey.shade400,
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide.none,
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                // stops: [0.3, 0.3],
                                colors: [
                                  Color(0xff7da1ef),
                                  Color.fromARGB(255, 127, 157, 237)
                                ]),
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Builder(builder: (context) {
                          if (provider.weatherData == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          double? temperture = provider.weatherData?.main.temp;
                          String? country = provider.weatherData?.sys.country;
                          String? description =
                              provider.weatherData?.weather[0].description ??
                                  '흐림';
                          double? feelLike =
                              provider.weatherData?.main.feelsLike;
                          int? humidity = provider.weatherData?.main.humidity;
                          double? windSpeed = provider.weatherData?.wind.speed;
                          return Stack(
                            children: [
                              Lottie.asset('images/102873-clouds-loop.json'),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      LineAwesomeIcons.map_marker,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      country!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${temperture!.floor()}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 70),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        description,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        weatherInfo(
                                            Icon(
                                              LineAwesomeIcons.wind,
                                              color: Colors.white,
                                            ),
                                            windSpeed.toString()),
                                        weatherInfo(
                                            Icon(
                                              LineAwesomeIcons.tint,
                                              color: Colors.white,
                                            ),
                                            humidity.toString()),
                                        weatherInfo(
                                            Icon(
                                              LineAwesomeIcons.low_temperature,
                                              color: Colors.white,
                                            ),
                                            feelLike.toString())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        })),
                  )
                ],
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

  Row weatherInfo(Icon icon, String info) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(
          info,
          style: TextStyle(color: Colors.white, fontSize: 15),
        )
      ],
    );
  }
}

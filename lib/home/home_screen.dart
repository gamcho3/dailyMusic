import 'package:daliy_music/API/API_list.dart';

import 'package:daliy_music/services/connectivityService.dart';

import 'package:daliy_music/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weatherBloc/weather_bloc.dart';
import '../services/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  static List imgList = [
    'https://images.unsplash.com/photo-1558486012-817176f84c6d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8d2VhdGhlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1561551331-7d7e8fd7ffb1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1651064199386-787549f0059c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1650542914658-948812530fa4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'
  ];

  final List<Widget> imageSliders = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(
          RepositoryProvider.of<WeatherAPI>(context),
          RepositoryProvider.of<ConnectivityService>(context))
        ..add(LoadApiEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: const Text(
            "daily Music",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(
                  Icons.people,
                  color: Colors.black,
                ))
          ],
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherNetworkErrorState) {
              return const Text('네트워크 에러');
            }
            if (state is WeatherLoadedState) {
              Map weatherMap = {
                'temp': state.temperture,
                'iconUrl':
                    'http://openweathermap.org/img/wn/${state.weatherIcon}@2x.png',
                'status': state.weatherDescription
              };
              return Column(
                children: [
                  Builder(builder: (context) {
                    var size = MediaQuery.of(context).size;
                    return CarouselSlider(
                        options: CarouselOptions(
                          height: size.height * 0.4,
                          viewportFraction: 0.83,
                          enableInfiniteScroll: false,
                          onPageChanged: ((index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                          autoPlay: false,
                          //aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/home/detailPage',
                                  arguments: imgList[0]);
                            },
                            child: Hero(
                              tag: 'first',
                              child: MainPostContainer(
                                index: 0,
                                weatherMap: weatherMap,
                                img: imgList[0],
                              ),
                            ),
                          ),
                          for (var i = 1; i < imgList.length; i++)
                            MainPostContainer(
                              img: imgList[i],
                              index: i,
                            ),
                        ]);
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                  IconButton(
                      onPressed: (() => BlocProvider.of<WeatherBloc>(context)
                          .add(LoadApiEvent())),
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ))
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class MainPostContainer extends StatelessWidget {
  final String img;
  final int index;
  final Map? weatherMap;
  const MainPostContainer(
      {Key? key, required this.img, required this.index, this.weatherMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
      margin: const EdgeInsets.all(2.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15)),
          ),
          Align(
              alignment: index != 0 ? Alignment.bottomLeft : Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: index != 0 ? TextAlign.start : TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                      children: index != 0
                          ? [
                              TextSpan(text: 'Welome\n'),
                              TextSpan(text: 'To\n'),
                              TextSpan(text: 'My World')
                            ]
                          : [
                              TextSpan(text: '${weatherMap!['temp']}\'C\n'),
                              WidgetSpan(
                                child: Image.network(weatherMap!['iconUrl']),
                              ),
                              TextSpan(text: '\n${weatherMap!['status']}')
                            ]),
                ),
              ))
          // Image.network(
          //   item,
          //   fit: BoxFit.cover,
          //   width: 1000.0,
          // ),
        ],
      ),
    );
  }
}

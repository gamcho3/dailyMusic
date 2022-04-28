import 'package:daliy_music/API/API_list.dart';
import 'package:daliy_music/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    var result = await LocationAPI.determinePosition();
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  static List imgList = [
    'https://images.unsplash.com/photo-1561551331-7d7e8fd7ffb1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1651064199386-787549f0059c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1650542914658-948812530fa4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'
  ];

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                image: DecorationImage(
                    image: NetworkImage(item), fit: BoxFit.cover)),
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                child: Stack(
              children: <Widget>[
                Container(),
                // Image.network(
                //   item,
                //   fit: BoxFit.cover,
                //   width: 1000.0,
                // ),
              ],
            )),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "daily Music",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Builder(builder: (context) {
                var size = MediaQuery.of(context).size;
                return CarouselSlider(
                  options: CarouselOptions(
                    height: size.height * 0.8,
                    enableInfiniteScroll: false,
                    onPageChanged: ((index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders,
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ],
          )),
    );
  }
}

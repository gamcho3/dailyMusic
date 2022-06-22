import 'package:animations/animations.dart';
import 'package:daliy_music/library/widget/card_detail.dart';
import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  const MusicCard(
      {Key? key, required this.size, required this.items, required this.index})
      : super(key: key);

  final Size size;
  final List items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
        transitionDuration: Duration(milliseconds: 500),
        openBuilder: (context, action) {
          return CardDetail(
            item: items[index],
          );
        },
        closedBuilder: (context, action) {
          return GestureDetector(
            onTap: () {
              action();
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: size.height * 0.5,
              width: size.width * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                  image: DecorationImage(
                      image: NetworkImage(items[index]['image']['hot']),
                      fit: BoxFit.fill)),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color.fromARGB(255, 39, 39, 39).withOpacity(0.9),
                  height: size.height * 0.1,
                  width: size.width * 0.6,
                  child: Center(
                    child: Text(
                      items[index]['title'],
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

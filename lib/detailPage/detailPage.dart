import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imgeSrc = ModalRoute.of(context)?.settings.arguments as String;
    print(imgeSrc);
    return Scaffold(
      body: Hero(
        tag: 'first',
        child: Container(
          child: Image.network(imgeSrc),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      )),
      body: Center(child: Text("라이브러리")),
    );
  }
}

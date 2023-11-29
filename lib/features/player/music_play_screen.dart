import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 음악플레이 화면
class MusicPlayScreen extends StatelessWidget {
  const MusicPlayScreen({super.key});

  static String get name => 'player';

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.down,
        onDismissed: (direction) => context.pop(),
        background: const ColoredBox(color: Colors.transparent),
        key: Key('playScreen'),
        child: Scaffold(
          backgroundColor: Colors.blueAccent,
          body: Center(child: Text("music")),
        ));
  }
}

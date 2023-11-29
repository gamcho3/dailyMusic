import 'package:daily_music/features/home/views/home_screen.dart';

import 'package:daily_music/features/navigation/navigation_view.dart';
import 'package:daily_music/features/player/music_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
              path: 'player',
              name: MusicPlayScreen.name,
              builder: (context, state) => MusicPlayScreen())
        ],
      )
    ],
  );
}

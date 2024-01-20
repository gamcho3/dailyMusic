import 'package:daily_music/features/create_music/presentation/view/create_music_screen.dart';
import 'package:daily_music/features/home/views/home_screen.dart';
import 'package:daily_music/features/player/presentation/views/music_play_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes.g.dart';
part './home_route.dart';
part './create_music_route.dart';
part './music_player_route.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
      initialLocation: '/', debugLogDiagnostics: true, routes: $appRoutes);
}

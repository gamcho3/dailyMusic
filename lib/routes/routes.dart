import 'package:daliy_music/ui/home/home_view.dart';
import 'package:daliy_music/ui/library/library_page.dart';

import 'package:daliy_music/ui/playlist/makeCard/make_playlist_page.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/library',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return HomeView(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/library',
          builder: (context, state) {
            return const LibraryPage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'makeList',
              builder: (context, state) {
                return const MakePlayListPage();
              },
            )
          ],
        )
      ],
    )
  ],
);

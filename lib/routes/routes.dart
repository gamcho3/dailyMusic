import 'package:daily_music/data/models/playList.dart';
import 'package:daily_music/ui/home/home_view.dart';
import 'package:daily_music/ui/library/library_page.dart';
import 'package:daily_music/ui/library/library_viewModel.dart';
import 'package:daily_music/ui/login/login_page.dart';
import 'package:daily_music/ui/musicCard/musicCard_page.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:path_to_regexp/path_to_regexp.dart';

import '../ui/makeCard/make_playlist_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/library',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return HomeView(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          name: "library",
          path: '/library',
          pageBuilder: (context, state) {
            return const MaterialPage(
                maintainState: false, child: LibraryPage());
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'login',
              path: 'login',
              builder: (context, state) {
                return const LoginPage();
              },
            ),
            GoRoute(
              name: 'makeList',
              path: 'makeList',
              builder: (context, state) {
                return const MakePlayListPage();
              },
            ),
            GoRoute(
              name: 'musicCard',
              path: 'musicCard/:index',
              builder: (context, state) {
                var index = int.parse(state.params['index']!);
                var item = state.extra as PlayList;

                return MusicCardPage(index: index, item: item);
              },
            )
          ],
        )
      ],
    )
  ],
);

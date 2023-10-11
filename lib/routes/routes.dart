import 'package:daily_music/data/models/playList.dart';
import 'package:daily_music/features/home/home_view.dart';
import 'package:daily_music/features/library/library_page.dart';
import 'package:daily_music/features/makeCard/make_playlist_page.dart';
import 'package:daily_music/features/musicCard/musicCard_page.dart';
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
                  var index = int.parse(state.pathParameters['index']!);
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
}

import 'package:daliy_music/bottom_navigation.dart';
import 'package:daliy_music/ui/library/youtube_player/youtube_player_page.dart';
import 'package:daliy_music/ui/playlist/makeCard/search_youtube/search_pages.dart';

import 'package:go_router/go_router.dart';

import '../ui/library/search/music_search_page.dart';

final router = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    builder: (context, state) {
      // String? index = state.queryParams['index'] ?? "0";

      return const BottomNavigationPage(
        pageIndex: 0,
      );
    },
    routes: [
      GoRoute(
          path: 'search',
          builder: ((context, state) {
            String keyword = state.queryParams['query'] ?? '';
            return MusicSearchPage(keyword: keyword);
          }),
          routes: [
            GoRoute(
              path: 'youtube/:pid',
              builder: ((context, state) {
                final String address = state.params['pid']!;

                return YoutubePlayerPage(
                  videoId: address,
                );
              }),
            )
          ])
    ],
  ),
  GoRoute(
    path: '/playList',
    builder: (context, state) {
      print("move page");
      return const BottomNavigationPage(
        pageIndex: 1,
      );
    },
  ),
], initialLocation: '/', debugLogDiagnostics: true, routerNeglect: true);

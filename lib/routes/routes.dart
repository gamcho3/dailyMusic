import 'package:daliy_music/bottom_navigation.dart';
import 'package:daliy_music/ui/playlist/makeCard/search_youtube/search_pages.dart';
import 'package:daliy_music/ui/search/music_search_page.dart';
import 'package:go_router/go_router.dart';

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
              String keyword = state.queryParams['query']!;

              return MusicSearchPage(keyword: keyword);
            }))
      ]),
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

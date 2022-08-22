import 'package:daliy_music/bottom_navigation.dart';
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
  ),
  GoRoute(
    path: '/playList',
    builder: (context, state) {
      return const BottomNavigationPage(
        pageIndex: 1,
      );
    },
  )
], initialLocation: '/', debugLogDiagnostics: true, routerNeglect: true);

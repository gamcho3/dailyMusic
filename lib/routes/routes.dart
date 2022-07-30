import 'package:daliy_music/bottom_navigation.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    name: 'main',
    builder: (context, state) => const BottomNavigationPage(),
  )
], initialLocation: '/', debugLogDiagnostics: true, routerNeglect: true);

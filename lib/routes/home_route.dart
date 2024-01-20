part of './routes.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<CreateMusicRoute>(path: 'create_music'),
    TypedGoRoute<MusicPlayerRoute>(path: 'player')
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

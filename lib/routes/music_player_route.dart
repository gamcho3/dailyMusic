part of './routes.dart';

class MusicPlayerRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    // TODO: implement buildPage
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: MusicPlayScreen(),
      barrierDismissible: true,
      barrierColor: Colors.black38,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation.drive(
            Tween<double>(begin: 1.0, end: 1.0).chain(
              CurveTween(curve: Curves.easeOutCubic),
            ),
          ),
          child: child,
        );
      },
    );
  }
}

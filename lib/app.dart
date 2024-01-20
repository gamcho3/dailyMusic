import 'package:daily_music/routes/routes.dart';
import 'package:daily_music/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  static const platform = MethodChannel('SHARE_URL');

  @override
  void initState() {
    // getUrl();
    super.initState();
  }

  Future<void> getUrl() async {
    String? url;
    try {
      url = await platform.invokeMethod("getYoutubeUrl");
    } on PlatformException catch (e) {
      url = e.toString();
    }
    print(":::::::::: url $url");
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'daily_music',
      theme: customThemeData,
      darkTheme: darkThemeData,
    );
  }
}

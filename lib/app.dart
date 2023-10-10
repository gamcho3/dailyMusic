import 'package:daily_music/routes/routes.dart';
import 'package:daily_music/utils/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('SHARE_URL');

  @override
  void initState() {
    getUrl();
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
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: child!,
      ),
      title: 'daily_music',
      theme: customThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
    );
  }
}

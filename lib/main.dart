import 'package:daliy_music/bottom_navigation.dart';
import 'package:daliy_music/color_schemes.g.dart';

import 'package:daliy_music/routes/routes.dart';
import 'package:daliy_music/view_models/card.dart';
import 'package:daliy_music/view_models/playlist.dart';
import 'package:daliy_music/view_models/youtubeProvider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // KakaoSdk.init(nativeAppKey: Constants.kakaoAppKey);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => YoutubeProvider()),
        ChangeNotifierProvider(create: (context) => AddListProvider()),
        ChangeNotifierProvider(create: (context) => PlayListProvider()),
      ],
      child: MaterialApp.router(
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
        title: 'daliy_music',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        themeMode: ThemeMode.system,
      ),
    );
  }
}

class HomeProvider extends StatelessWidget {
  const HomeProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BottomNavigationPage();
  }
}

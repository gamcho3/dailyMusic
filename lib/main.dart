import 'package:daliy_music/bottom_navigation.dart';
import 'package:daliy_music/color_schemes.g.dart';
import 'package:daliy_music/data/models/temp_musicList.dart';
import 'package:daliy_music/firebase_options.dart';
import 'package:daliy_music/routes/routes.dart';
import 'package:daliy_music/utils/theme/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TempMusicListAdapter());
  await Hive.openBox<TempMusicList>('tempMusicList');
  await dotenv.load();
  // KakaoSdk.init(nativeAppKey: Constants.kakaoAppKey);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
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
      title: 'daliy_music',
      theme: themeData,
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.notoSansNKoTextTheme()),
      themeMode: ThemeMode.system,
    );
  }
}

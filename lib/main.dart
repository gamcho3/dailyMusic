import 'package:daily_music/config/di.dart';
import 'package:daily_music/data/models/temp_musicList.dart';
import 'package:daily_music/firebase_options.dart';
import 'package:daily_music/routes/routes.dart';
import 'package:daily_music/utils/theme/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
//hive 생성
  await Hive.initFlutter();
  Hive.registerAdapter(TempMusicListAdapter());
  await Hive.openBox<TempMusicList>('tempMusicList');
  await dotenv.load();
  setupGetIt();
  KakaoSdk.init(nativeAppKey: 'bf0892b557f7ab104a34756adc2e04ea');
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
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
    );
  }
}

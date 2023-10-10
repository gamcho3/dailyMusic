import 'package:daily_music/app.dart';
import 'package:daily_music/config/di.dart';
import 'package:daily_music/data/models/temp_musicList.dart';
import 'package:daily_music/firebase_options.dart';
import 'package:daily_music/routes/routes.dart';
import 'package:daily_music/utils/theme/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //hive 생성
  await Hive.initFlutter();
  Hive.registerAdapter(TempMusicListAdapter());
  await Hive.openBox<TempMusicList>('tempMusicList');
  await dotenv.load();
  setupGetIt();
  // KakaoSdk.init(nativeAppKey: 'bf0892b557f7ab104a34756adc2e04ea');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

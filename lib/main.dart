import 'package:daily_music/app.dart';
import 'package:daily_music/config/di.dart';
import 'package:daily_music/firebase_options.dart';
import 'package:daily_music/routes/routes.dart';
import 'package:daily_music/utils/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:http/http.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //hive 생성

  //환경변수 활성화
  await dotenv.load();
  setupGetIt();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MobileAds.instance.initialize();
  runApp(const ProviderScope(child: MyApp()));
}

import 'package:daliy_music/bottom_navigation.dart';
import 'package:daliy_music/home/home_screen.dart';
import 'package:daliy_music/routes/routes.dart';

import 'package:daliy_music/services/connectivityService.dart';
import 'package:daliy_music/services/weather.dart';
import 'package:daliy_music/services/youtube.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:google_fonts/google_fonts.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => WeatherAPI()),
        RepositoryProvider(create: (context) => YoutubeServices()),
        RepositoryProvider(create: (context) => ConnectivityService())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: customRoutes,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.light,
              primary: const Color(0xff00C853),
              secondary: const Color(0xffA5D6A7),
              background: Color.fromARGB(255, 249, 249, 249)),
          textTheme: GoogleFonts.nanumGothicTextTheme(),
        ),
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

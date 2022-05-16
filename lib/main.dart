import 'package:daliy_music/constants/constants.dart';
import 'package:daliy_music/home/home_screen.dart';
import 'package:daliy_music/routes/routes.dart';
import 'package:daliy_music/services/connectivityService.dart';
import 'package:daliy_music/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  KakaoSdk.init(nativeAppKey: Constants.kakaoAppKey);
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
    return MaterialApp(
      initialRoute: '/',
      routes: customRoutes,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => WeatherAPI()),
        RepositoryProvider(
          create: ((context) => ConnectivityService()),
        )
      ],
      child: const HomeScreen(),
    );
  }
}

import 'package:daliy_music/detailPage/detailPage.dart';
import 'package:daliy_music/home/home_screen.dart';
import 'package:daliy_music/login/loginPage.dart';
import 'package:flutter/material.dart';

import '../main.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => const HomeProvider(),
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginPage(),
  '/home/detailPage': (context) => const DetailPage()
};

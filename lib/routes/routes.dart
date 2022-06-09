import 'package:daliy_music/home/home_screen.dart';
import 'package:daliy_music/youtube_list/view/search.dart';

import 'package:flutter/material.dart';

import '../main.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => const HomeProvider(),
  '/home': (context) => const HomeScreen(),
  '/search': (context) => const SearchPage()
};

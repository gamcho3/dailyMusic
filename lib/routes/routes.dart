import 'package:flutter/material.dart';

import '../main.dart';
import '../views/youtube_list/search.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => const HomeProvider(),
  '/search': (context) => const SearchPage(),
};

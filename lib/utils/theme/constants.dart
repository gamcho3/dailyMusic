import 'package:flutter/material.dart';

import '../../color_schemes.g.dart';

final themeData = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    primaryColor: const Color(0xFF695F00),
    textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));

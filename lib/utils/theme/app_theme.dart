import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color_schemes.g.dart';

final customThemeData = ThemeData(
  brightness: lightColorScheme.brightness,
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.nanumGothicTextTheme().copyWith(
    titleLarge: TextStyle(fontSize: 20, color: Colors.black),
    titleMedium: TextStyle(fontSize: 16, color: Colors.black),
    titleSmall: TextStyle(fontSize: 14, color: Colors.black),
  ),
);

final darkThemeData = ThemeData(
  brightness: darkColorScheme.brightness,
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: GoogleFonts.nanumGothicTextTheme().copyWith(
    titleLarge: TextStyle(fontSize: 20, color: Colors.white),
    titleMedium: TextStyle(fontSize: 16, color: Colors.white),
    titleSmall: TextStyle(fontSize: 14, color: Colors.white),
  ),
);

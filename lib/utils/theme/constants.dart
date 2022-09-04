import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color_schemes.g.dart';

final themeData = ThemeData(
    brightness: lightColorScheme.brightness,
    useMaterial3: true,
    colorScheme: lightColorScheme,
    primaryColor: const Color(0xFF695F00),
    textTheme: GoogleFonts.notoSansNKoTextTheme());

final darkThemeData = ThemeData(
    brightness: darkColorScheme.brightness,
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: GoogleFonts.notoSansNKoTextTheme());

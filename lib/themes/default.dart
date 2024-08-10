import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData defaultTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    primary: Color(0XFF04021D),
    secondary: Color(0XFF686777),
    primaryContainer: Color(0XFF2B637B),
    onPrimary: Colors.white,
    onSurface: Color(0XFF04021D),
    onSecondary: Color(0XFF554AF0),
    inversePrimary: Colors.white,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
);

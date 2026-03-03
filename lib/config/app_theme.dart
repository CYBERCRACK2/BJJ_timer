import 'package:flutter/material.dart';

class BjjTheme {
  // Define your seed colors here or pass them directly
  static const Color _seedColorLight = Color(0xFFFFFFFF);
  static const Color _seedColorDark = Color(0xFF011C26);

  // Cambiar la fuente
  static const String fontFamilyName = 'Verdana';

  static const TextTheme _bjjTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 350,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
      fontFamily: fontFamilyName, // Applied here
    ),
    displayLarge: TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
      fontFamily: fontFamilyName, // Applied here
    ),
    headlineMedium: TextStyle(
      fontSize: 54,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.25,
      fontFamily: fontFamilyName, // Applied here
    ),
    headlineSmall: TextStyle(
      fontSize: 54,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.25,
      fontFamily: fontFamilyName, // Applied here
    ),
    labelLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.25,
      fontFamily: fontFamilyName, // Applied here
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
      fontFamily: fontFamilyName, // Applied here
    ),
  );

  // Light Theme Definition
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: _bjjTextTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColorLight,
      brightness: Brightness.light,
    ),
  );

  // Dark Theme Definition
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: _bjjTextTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColorDark,
      brightness: Brightness.dark,
    ),
  );
}

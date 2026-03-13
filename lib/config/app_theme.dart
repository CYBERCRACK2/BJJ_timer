import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({required this.isDarkMode});
  // Define your seed colors here or pass them directly
  static const Color _seedColor = Color.fromARGB(255, 118, 4, 0);

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

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    textTheme: _bjjTextTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    ),
  );
}

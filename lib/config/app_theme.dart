import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final bool isDarkMode;
  AppTheme({required this.isDarkMode});

  static const Color _seedColor = Color.fromARGB(255, 118, 4, 0);

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      // Aplicamos la fuente agresiva (Anton) manteniendo tus estilos definidos abajo
      textTheme: GoogleFonts.blackOpsOneTextTheme(_bjjTextTheme).copyWith(
        bodyMedium: _bjjTextTheme.bodyMedium,
        headlineLarge: _bjjTextTheme.headlineLarge,
        displayMedium: _bjjTextTheme.displayMedium,
      ),
      appBarTheme: AppBarTheme(centerTitle: true),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  static const TextTheme _bjjTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 350, // Respetado tu tamaño original
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
      fontFamily: 'verdana',
    ),
    displayLarge: TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      fontSize: 120,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.5,
      fontFamily: 'verdana',
    ),
    headlineMedium: TextStyle(
      fontSize: 54,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.25,
    ),
    headlineSmall: TextStyle(
      fontSize: 54,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.25,
    ),
    labelLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.25,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
      fontFamily: 'verdana',
    ),
    bodySmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
    ),
  );
}

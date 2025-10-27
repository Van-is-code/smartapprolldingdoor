import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = (BuildContext context) {
  final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);
  return ThemeData(
    brightness: Brightness.dark,
    // ... (Copy toàn bộ ThemeData từ MyApp) ...
    scaffoldBackgroundColor: const Color(0xFF1A1C2E),
    primaryColor: const Color(0xFF6E5FFF),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6E5FFF),
      secondary: Color(0xFF03DAC6),
      background: Color(0xFF1A1C2E),
      surface: Color(0xFF2C2F48),
    ),
    textTheme: textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1A1C2E),
      elevation: 0,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF2C2F48),
      selectedItemColor: const Color(0xFF6E5FFF),
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6E5FFF),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2F48),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: Colors.white38),
    ),
  );
};
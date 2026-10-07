import 'package:flutter/material.dart';

class DarbTheme {
  static const Color primaryNavy = Color(0xFF0F172A); // Deeper, modern navy
  static const Color secondaryNavy = Color(0xFF1E293B);
  static const Color accentGold = Color(0xFFEAB308); // Vibrant, premium gold
  static const Color accentGoldGlow = Color(0xFFFDE047);
  static const Color surfaceDark = Color(0xFF111827);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color textMuted = Color(0xFF64748B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryNavy,
      scaffoldBackgroundColor: surfaceLight,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryNavy,
        primary: primaryNavy,
        secondary: accentGold,
        surface: Colors.white,
      ),
      fontFamily: 'Tajawal',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w800, color: textDark, letterSpacing: -0.5),
        bodyLarge: TextStyle(color: textDark),
        bodyMedium: TextStyle(color: textMuted),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryNavy,
      scaffoldBackgroundColor: surfaceDark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryNavy,
        primary: primaryNavy,
        secondary: accentGold,
        surface: secondaryNavy,
      ),
      fontFamily: 'Tajawal',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textLight,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w800, color: textLight, letterSpacing: -0.5),
        bodyLarge: TextStyle(color: textLight),
        bodyMedium: TextStyle(color: textMuted),
      ),
    );
  }
}

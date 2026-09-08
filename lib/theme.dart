import 'package:flutter/material.dart';

class AppTheme {
  static const Color noirProfound = Color(0xFF0D0D0D);
  static const Color charcoal = Color(0xFF1A1A1A);
  static const Color crisArdois = Color(0xFF2B2D31);
  static const Color grisClair = Color(0xFFA8ACB1);
  static const Color blancPur = Color(0xFFF7F7F7);
  static const Color argentMetallise = Color(0xFFC0C4C9);
  static const Color taupeChic = Color(0xFFA69A89);
  static const Color bronzeLux = Color(0xFFB08D57);
  static const Color bleuNuit = Color(0xFF0F172A);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: bleuNuit,
      scaffoldBackgroundColor: noirProfound,
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: blancPur,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: blancPur,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: grisClair,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: argentMetallise,
          fontSize: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bronzeLux,
          foregroundColor: noirProfound,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: charcoal,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: crisArdois),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: crisArdois),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: bronzeLux),
        ),
        labelStyle: const TextStyle(color: grisClair),
        hintStyle: const TextStyle(color: grisClair),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(color: blancPur),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: charcoal,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: crisArdois),
          ),
        ),
      ),
    );
  }
}
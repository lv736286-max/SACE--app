import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFB71C1C);
  static const Color background = Color(0xFFF5F2F0);
  static const Color accent = Color(0xFFEFEFEF);
  static const Color text = Color(0xFF333333);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.text),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.text),
      labelLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

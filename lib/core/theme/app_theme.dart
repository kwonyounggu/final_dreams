import 'package:flutter/material.dart';

/*
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2C3E50), // Sophisticated Blue-Grey
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        displayMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }
}
*/


class AppTheme {
  static final theme = ThemeData(
    primaryColor: const Color(0xFF2C6E6E), // muted teal
    fontFamily: 'Inter', // or 'Merriweather' for body
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 16, height: 1.5),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFE8D7B5), // warm beige
    ),
  );
}

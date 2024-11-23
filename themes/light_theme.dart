import 'package:flutter/material.dart';

final lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF4CAF50), // Yeşil tonları
    secondary: Color(0xFF8BC34A),
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4CAF50),
    foregroundColor: Colors.white,
  ),
);
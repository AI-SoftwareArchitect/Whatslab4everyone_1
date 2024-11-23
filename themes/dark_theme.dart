import 'dart:ui';
import 'package:flutter/material.dart';

final darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF4CAF50), // Yeşil tonları
    secondary: Color(0xFF8BC34A),
    surface: Color(0xFF121212),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4CAF50),
    foregroundColor: Colors.white,
  ),
);
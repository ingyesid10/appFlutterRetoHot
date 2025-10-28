import 'package:flutter/material.dart';

final ThemeData neonArcadeTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0A001F),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFF00FF), // Rosa neón
    secondary: Color(0xFF00FFFF), // Cian neón
    surface: Color(0xFF1A0033),
    onPrimary: Colors.white,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF140033),
    elevation: 8,
    shadowColor: Color(0xFFFF00FF),
    titleTextStyle: TextStyle(
      fontFamily: 'Orbitron',
      color: Color(0xFF00FFFF),
      fontSize: 22,
      letterSpacing: 2,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFFFF00FF)),
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      shadowColor: WidgetStatePropertyAll(Color(0xFF00FFFF)),
      elevation: WidgetStatePropertyAll(10),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontFamily: 'Orbitron',
        fontSize: 16,
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
      )),
    ),
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Orbitron',
      color: Color(0xFFFF00FF),
      fontSize: 26,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.8,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'PressStart2P',
      color: Colors.white,
      fontSize: 12,
      height: 1.4,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'PressStart2P',
      color: Color(0xFFBBBBFF),
      fontSize: 10,
      height: 1.3,
    ),
  ),

  // 🔧 CORREGIDO: ahora usa CardThemeData (no CardTheme)
  cardTheme: CardThemeData(
    color: const Color(0xFF150040),
    elevation: 6,
    shadowColor: const Color(0xFFFF00FF),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFF00FFFF), width: 1),
    ),
  ),
);

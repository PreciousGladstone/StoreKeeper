import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';



final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    secondary: Color(0xFF446FFB),
    onPrimary: const Color.fromARGB(255, 86, 86, 86),
    onSecondary: Color(0xFFF2F4F5),
    onSecondaryFixed:  const Color.fromARGB(255, 190, 214, 255),
    tertiary: Colors.grey.shade300,
    onTertiary: Color(0xFFACB0B1),
    onError: Colors.redAccent,
  ),
  // textTheme: 
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
    ),
  ),
);

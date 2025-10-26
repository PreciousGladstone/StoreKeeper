import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';



final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.blueAccent,
    onPrimary: const Color.fromARGB(255, 86, 86, 86),
    onSecondary: const Color.fromARGB(255, 241, 239, 239),
    tertiary: Colors.grey.shade100
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

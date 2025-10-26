import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color.fromRGBO(149, 117, 205, 1),
    secondary: Colors.white,
    
  ),
  textTheme: GoogleFonts.interTextTheme(),
  appBarTheme: AppBarTheme(backgroundColor: Color.fromRGBO(149, 117, 205, 1)),
);

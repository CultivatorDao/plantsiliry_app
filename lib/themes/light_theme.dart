import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
    // Bold headline style
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
      color: Colors.black
    ),
    // Regular headline style
    headlineSmall: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.none,
      color: Color.fromARGB(255, 104, 103, 119)
    ),
    // Bold text style
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: Color.fromARGB(255, 104, 103, 119)
    ),
    // Regular text style
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: Color.fromARGB(255, 104, 103, 119)
    ),
    // temp!!!
    displaySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5
    ),
    // Button textStyles
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: Color.fromARGB(255, 44, 94, 70),
    )
  ),
  splashColor: Colors.transparent,
  fontFamily: "Poppins",
);



import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Color(0xFF21252B);
  static const Color secondary = Color(0xFF33373E);
  static const Color accent = Color(0xFF61C19C);
  static const Color background = Color(0xFFEBEBEB);

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      secondary: secondary,
      surface: background,
      background: background,
      error: Colors.redAccent,
      onPrimary: Colors.white, // text color on the primary color
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ), // For title "Movie DB App"
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ), // For "Categories" & movie titles, 
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ), // For "Categories" & movie titles, 
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ), // For "Release Date" & "Average Rating"
      bodySmall: TextStyle(
        fontSize: 13,
        color: Colors.white,
      ), // For little descriptions
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: secondary,
      ), // For buttons like "Watch List"
    ),
  );


}
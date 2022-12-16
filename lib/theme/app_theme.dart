import 'package:flutter/material.dart';

class AppTheme {
  static final isDark = false;
  static final theme = isDark ? darkTheme : lightTheme;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(elevation: 0),
    iconTheme: IconThemeData(color: Colors.white),
    primaryColor: Colors.white,
  );
}

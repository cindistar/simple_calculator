import 'package:flutter/material.dart';

class SimpleCalculatorTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    iconTheme: const IconThemeData(color: Colors.pink),
    textTheme: textTheme,
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.pink,
     textTheme: textTheme,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      primary: Colors.white,
    )),
  );
  static const textTheme = TextTheme(
    bodyText2: TextStyle(fontSize: 20),
    button: TextStyle(fontSize: 20),
  );
}

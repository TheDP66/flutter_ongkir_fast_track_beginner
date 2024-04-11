import 'package:flutter/material.dart';

const appRed = Color(0xFFB71C1C);
const appPink = Color(0xFFf528cc);
const appBlack = Colors.black;
const appWhite = Colors.white;
const appGreen = Color.fromARGB(255, 81, 195, 89);
const appBlue = Color.fromARGB(255, 117, 181, 255);

ThemeData light = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: appGreen,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: appPink,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appBlue,
    ),
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: appWhite,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: appBlack,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appBlue,
    ),
  ),
  backgroundColor: appBlack,
);

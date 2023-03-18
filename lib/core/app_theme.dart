import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: const Color(0xFF007084),
  backgroundColor: const Color(0xFFF2F5F9),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFF007084),
  ),
  primaryColorLight: const Color(0xFF007084),
  primaryColorDark: const Color(0xFF007084),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF007084),
  ),
  unselectedWidgetColor: const Color(0xffBDC3C7),
  appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: const Color(0xFF007084),
      iconTheme: const IconThemeData(
        color: Colors.white,
      )),
  canvasColor: const Color(0xFFF2F5F9),
);

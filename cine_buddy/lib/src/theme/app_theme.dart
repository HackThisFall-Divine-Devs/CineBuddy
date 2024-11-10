import 'package:cine_buddy/src/utils/colors_sys.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    primaryColor: ColorSys.ksecondary,
    scaffoldBackgroundColor: ColorSys.kprimary,
    fontFamily: 'Sk-Modernist',
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: ColorSys.kwhite,
        fontSize: 24,
        fontFamily: "Sk-Modernist",
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: ColorSys.kwhite,
        fontSize: 16,
        fontFamily: "Sk-Modernist",
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: ColorSys.kwhite,
        fontSize: 16,
        fontFamily: "Sk-Modernist",
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFFFD6637);
  static const Color lightGrey = Color(0xFFC4C4C4);
  static const Color buttonSecondary = Color(0xFF0BCE83);
  static const Color textSecondary = Color(0xFF9586A8);

  static const String fontName = 'SourceSansPro';

  static const TextTheme textTheme = TextTheme(
    headline5: headline,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: primaryColor,
  );
}

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFFFD6637);
  static const Color lightGrey = Color(0xFFC4C4C4);
  static const Color buttonSecondary = Color(0xFF0BCE83);
  static const Color textSecondary = Color(0xFF9586A8);
  static const Color strongPurple = Color(0xFF2D0C57);

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
  static const TextStyle normaltext = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    letterSpacing: 0.27,
    color: textSecondary,
  );
  static const TextStyle header = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 25,
    letterSpacing: 0.27,
    color: strongPurple,
  );
  static const TextStyle regularGreen = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    letterSpacing: 0.27,
    color: buttonSecondary,
  );
}

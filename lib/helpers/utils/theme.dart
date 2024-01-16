import 'package:flutter/material.dart';

class ThemeHelper {
  static const TextTheme _textTheme = TextTheme(
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xff959595),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xff959595),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C1C1C),
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C1C1C),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Vazir',
    primaryColor: const Color(0xffD91313),
    useMaterial3: false,
    hintColor: const Color(0xff959595),
    scaffoldBackgroundColor: const Color(0xffF5F5F5),
    textTheme: _textTheme,
    dividerColor: const Color(0xffECECEC),
    iconTheme: const IconThemeData(
      color: Color(0xffD91313),
    ),
    colorScheme: const ColorScheme.light(
      onPrimary: Colors.white,
      primary: Color(0xffD91313),
      secondary: Color(0xff0C5EDA),
      onSecondary: Color(0xff1C1C1C),
      // secondaryContainer: Color(0xffF1F1F1),
      // primaryContainer: Color(0xffDAF2FF),
      // tertiary: Color(0xffF6F6F6),
    ),
  );
}

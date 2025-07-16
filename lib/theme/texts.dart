import 'package:flutter/material.dart';

TextTheme buildAppTextTheme(TextTheme base) {
  TextStyle fontFamilyText = TextStyle(fontFamily: 'Inter');
  final headlineBase = fontFamilyText.copyWith(fontWeight: FontWeight.bold);
  final bodyBase = fontFamilyText.copyWith(fontWeight: FontWeight.w500);

  return base.copyWith(
    headlineLarge: headlineBase.copyWith(fontSize: 24),
    headlineMedium: headlineBase.copyWith(fontSize: 20),
    headlineSmall: headlineBase.copyWith(fontSize: 16),
    displayLarge: fontFamilyText.copyWith(fontSize: 24),
    displayMedium: fontFamilyText.copyWith(fontSize: 20),
    displaySmall: fontFamilyText.copyWith(fontSize: 16),
    bodyLarge: bodyBase.copyWith(fontSize: 24),
    bodyMedium: bodyBase.copyWith(fontSize: 20),
    bodySmall: bodyBase.copyWith(fontSize: 16),

  );
}

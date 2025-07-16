import 'package:flutter/material.dart';
import 'package:musico_app/theme/colors.dart';
import 'package:musico_app/theme/texts.dart';

ThemeData createAppTheme() {
  final base = ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: buildAppTextTheme(
      base.textTheme,
    ).apply(displayColor: AppColors.white75, bodyColor: AppColors.white75),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: AppColors.background,
      selectedColor: AppColors.white12,
      selectedShadowColor: AppColors.background,
      surfaceTintColor: AppColors.white75,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      showCheckmark: false,
      labelStyle: TextStyle(color: AppColors.white50, fontWeight: FontWeight.bold)
    ),
  );
}

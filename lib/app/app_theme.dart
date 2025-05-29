import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.lightText),
    bodyMedium: TextStyle(color: AppColors.lightText),
    bodySmall: TextStyle(color: AppColors.lightText,fontSize: 14),
    titleLarge: TextStyle(
      color: AppColors.lightText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.lightBackground,
    brightness: Brightness.light,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
    bodySmall: TextStyle(color: AppColors.darkText,fontSize: 14),
    titleLarge: TextStyle(
      color: AppColors.darkText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.darkBackground,
    brightness: Brightness.dark,
  ),
);

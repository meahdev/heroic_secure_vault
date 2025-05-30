import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// Defines the light theme configuration for the app
final ThemeData lightTheme = ThemeData(
  // Sets overall brightness to light
  brightness: Brightness.light,

  // Sets scaffold background color for light mode
  scaffoldBackgroundColor: AppColors.lightBackground,

  // Defines default text styles for different text elements in light mode
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.lightText),
    bodyMedium: TextStyle(color: AppColors.lightText),
    bodySmall: TextStyle(color: AppColors.lightText, fontSize: 14),
    titleLarge: TextStyle(
      color: AppColors.lightText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Sets the color scheme using a seed color for consistent theming
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.lightBackground,
    brightness: Brightness.light,
  ),
);

/// Defines the dark theme configuration for the app
final ThemeData darkTheme = ThemeData(
  // Sets overall brightness to dark
  brightness: Brightness.dark,

  // Sets scaffold background color for dark mode
  scaffoldBackgroundColor: AppColors.darkBackground,

  // Defines default text styles for different text elements in dark mode
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
    bodySmall: TextStyle(color: AppColors.darkText, fontSize: 14),
    titleLarge: TextStyle(
      color: AppColors.darkText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Sets the color scheme using a seed color for consistent theming
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.darkBackground,
    brightness: Brightness.dark,
  ),
);

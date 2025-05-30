import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../storage/shared_prefs_service.dart';

/// Enum to represent the available app themes.
enum AppTheme { light, dark }

/// Cubit to manage the app's theme mode (light or dark).
///
/// It uses [SharedPrefsService] to persist the user's theme preference
/// across app launches by saving a boolean flag 'is_dark_theme'.
class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPrefsService prefsService;

  /// Creates a [ThemeCubit] and loads the saved theme preference.
  ThemeCubit(this.prefsService) : super(ThemeMode.dark) {
    _loadSavedTheme();
  }

  /// Loads the saved theme from shared preferences.
  ///
  /// Defaults to light theme if no preference is found.
  Future<void> _loadSavedTheme() async {
    final isDark = prefsService.getBool('is_dark_theme') ?? true;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Toggles the theme between light and dark modes.
  ///
  /// Updates the saved preference in shared preferences accordingly.
  void toggleTheme() {
    final newTheme =
    state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    prefsService.setBool('is_dark_theme', newTheme == ThemeMode.dark);
    emit(newTheme);
  }
}

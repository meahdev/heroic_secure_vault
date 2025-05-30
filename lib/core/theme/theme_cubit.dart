import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../storage/shared_prefs_service.dart';

enum AppTheme { light, dark }

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPrefsService prefsService;
  ThemeCubit(this.prefsService) : super(ThemeMode.light) {
    _loadSavedTheme();
  }
  Future<void> _loadSavedTheme() async {
    final isDark = prefsService.getBool('is_dark_theme') ?? true;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    final newTheme =
    state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    prefsService.setBool('is_dark_theme', newTheme == ThemeMode.dark);
    emit(newTheme);
  }
}


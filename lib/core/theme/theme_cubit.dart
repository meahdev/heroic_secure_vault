import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  void setTheme(AppTheme theme) {
    if (theme == AppTheme.light) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.dark);
    }
  }
}


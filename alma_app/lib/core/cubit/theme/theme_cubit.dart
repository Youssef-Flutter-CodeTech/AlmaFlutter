// theme_cubit.dart
import 'package:alma_app/core/services/locale_service.dart';
import 'package:alma_app/core/utils/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_constants.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_getThemeMode());

  // Retrieve cached ThemeMode or default to ThemeMode.system
  static ThemeMode _getThemeMode() {
    final saved = sl<CashHelper>().getString(AppConstants.themeKey);
    switch (saved) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  // Set and cache a new ThemeMode
  Future<void> setTheme(ThemeMode mode) async {
    final String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
        modeString = 'system';
        break;
    }
    await sl<CashHelper>().set(AppConstants.themeKey, modeString);
    emit(mode);
  }

  // Getter for themeMode (not strictly necessary since state is already ThemeMode)
  ThemeMode get themeMode => state;
}

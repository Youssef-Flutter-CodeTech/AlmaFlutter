import 'package:alma_app/core/services/locale_service.dart';
import 'package:alma_app/core/utils/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(_getInitialTheme()));

  static ThemeMode _getInitialTheme() {
    final savedTheme = sl<CashHelper>().get(AppConstants.themeKey);
    if (savedTheme == 'dark') return ThemeMode.dark;
    if (savedTheme == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    await sl<CashHelper>().set(AppConstants.themeKey, newTheme.name);
    emit(ThemeState(newTheme));
  }
}

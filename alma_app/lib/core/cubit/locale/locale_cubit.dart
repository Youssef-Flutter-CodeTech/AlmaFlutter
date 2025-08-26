import 'package:alma_app/core/services/locale_service.dart';
import 'package:alma_app/core/services/navigation_service.dart';
import 'package:alma_app/core/utils/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_constants.dart';

class LocaleCubit extends Cubit<LocaleState> {
  // List of supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  LocaleCubit() : super(LocaleState(_getInitialLocale()));

  static Locale _getInitialLocale() {
    final savedLocale = sl<CashHelper>().getString(AppConstants.languageKey);
    // Check if the saved locale is supported
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == savedLocale,
      orElse: () => const Locale('en'), // Default to English if not found
    );
  }

  Future<void> changeLocale(Locale newLocale) async {
    // Validate that the new locale is supported
    if (!supportedLocales.contains(newLocale)) {
      return; // Do nothing if the locale is not supported
    }
    // Save to local storage
    await sl<CashHelper>()
        .set(AppConstants.languageKey, newLocale.languageCode);
    // Notify navigation service to update app-wide locale
    NavigationService.changeLanguage();
    // Emit new state
    emit(LocaleState(newLocale));
  }
}

// Define LocaleState in the part file

class LocaleState {
  final Locale locale;

  LocaleState(this.locale);
}

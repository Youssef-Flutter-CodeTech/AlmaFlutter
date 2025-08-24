import 'package:alma_app/core/services/locale_service.dart';
import 'package:alma_app/core/utils/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_constants.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(_getInitialLocale()));

  static Locale _getInitialLocale() {
    final savedLocale = sl<CashHelper>().get(AppConstants.languageKey);
    return savedLocale == 'ar' ? const Locale('ar') : const Locale('en');
  }

  Future<void> changeLocale(Locale newLocale) async {
    await sl<CashHelper>()
        .set(AppConstants.languageKey, newLocale.languageCode);
    emit(LocaleState(newLocale));
  }
}

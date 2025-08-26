import 'package:alma_app/core/services/locale_service.dart';
import 'package:alma_app/core/utils/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_constants.dart';

class PrimaryColorCubit extends Cubit<Color> {
  PrimaryColorCubit() : super(_getInitialColor());
  static Color _getInitialColor() {
    final savedColor = sl<CashHelper>().getString(AppConstants.primaryColorKey);
    if (savedColor != null && savedColor.startsWith('0xFF')) {
      try {
        appColor = Color(int.parse(savedColor));
        return Color(int.parse(savedColor));
      } catch (_) {}
    }
    return Color(0xFFEF4137);
  }

  Future<void> setPrimaryColor(Color color) async {
    final hexString =
        '0xFF${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
    await sl<CashHelper>().set(AppConstants.primaryColorKey, hexString);
    appColor = color;
    emit(color);
  }
}

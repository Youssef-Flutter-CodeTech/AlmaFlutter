import 'package:alma_app/core/theme/app_font_weights.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle? get text28Bold => TextStyle(
      fontSize: ResponsiveHelper.fontSize(28),
      fontWeight: AppFontWeights.bold,
      fontFamily: 'IBMPlexSans');

  static TextStyle? get text16Regular => TextStyle(
      fontSize: ResponsiveHelper.fontSize(16),
      fontWeight: AppFontWeights.regular,
      fontFamily: 'IBMPlexSans');
  static TextStyle? get text16Medium => TextStyle(
      fontSize: ResponsiveHelper.fontSize(16),
      fontWeight: AppFontWeights.medium,
      fontFamily: 'IBMPlexSans');
  static TextStyle? get text16Bold => TextStyle(
      fontSize: ResponsiveHelper.fontSize(16),
      fontWeight: AppFontWeights.bold,
      fontFamily: 'IBMPlexSans');
  static TextStyle? get text16SemiBold => TextStyle(
      fontSize: ResponsiveHelper.fontSize(16),
      fontWeight: AppFontWeights.semiBold,
      fontFamily: 'IBMPlexSans');
  static TextStyle? get text14Regular => TextStyle(
      fontSize: ResponsiveHelper.fontSize(14),
      fontWeight: AppFontWeights.regular,
      fontFamily: 'IBMPlexSans');
  static TextStyle? get text14Bold => TextStyle(
      fontSize: ResponsiveHelper.fontSize(14),
      fontWeight: AppFontWeights.bold,
      fontFamily: 'IBMPlexSans');
  static TextStyle? get text14Medium => TextStyle(
      fontSize: ResponsiveHelper.fontSize(14),
      fontWeight: AppFontWeights.medium,
      fontFamily: 'IBMPlexSans');
  static TextStyle? get text14SemiBold => TextStyle(
      fontSize: ResponsiveHelper.fontSize(14),
      fontWeight: AppFontWeights.semiBold,
      fontFamily: 'IBMPlexSans');

  static TextStyle? get text12Regular => TextStyle(
      fontSize: ResponsiveHelper.fontSize(12),
      fontWeight: AppFontWeights.regular,
      fontFamily: 'IBMPlexSans');
}

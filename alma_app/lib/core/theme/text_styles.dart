import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle? get text28Bold => TextStyle(
      fontSize: ResponsiveHelper.fontSize(28),
      fontWeight: FontWeight.bold,
      fontFamily: 'IBMPlexSans');

  static TextStyle? get text16BoldRegular => TextStyle(
      fontSize: ResponsiveHelper.fontSize(16),
      fontWeight: FontWeight.normal,
      fontFamily: 'IBMPlexSans');

  static TextStyle? get text12BoldRegular => TextStyle(
      fontSize: ResponsiveHelper.fontSize(12),
      fontWeight: FontWeight.normal,
      fontFamily: 'IBMPlexSans');
}

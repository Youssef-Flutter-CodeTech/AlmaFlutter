// app_theme.dart
import 'package:alma_app/core/constants/app_constants.dart';
import 'package:alma_app/core/cubit/color/color_cubit.dart';
import 'package:alma_app/core/services/locale_service.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppTheme {
  // 🎨 Helper: Create TextStyle with responsive size
  static TextStyle _textStyle(
      double baseSize, FontWeight weight, Color? color) {
    return TextStyle(
      fontSize: ResponsiveHelper.fontSize(baseSize, tabletSize: baseSize * 1.3),
      fontWeight: weight,
      fontFamily: 'IBMPlexSans',
      color: color,
    );
  }

  // 🌓 Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: appColor,
      scaffoldBackgroundColor: AppColor.bgWhite,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme.light(
        primary: appColor,
        secondary: AppColor.secondary,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: AppColor.bgWhite,
        onSurface: AppColor.bodyText,
        error: Colors.red,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.bgWhite,
        iconTheme: const IconThemeData(color: AppColor.primaryText),
        titleTextStyle: TextStyle(
          color: AppColor.primaryText,
          fontSize: ResponsiveHelper.fontSize(18, tabletSize: 22),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: _textStyle(24, FontWeight.bold, AppColor.primaryText),
        displayMedium: _textStyle(20, FontWeight.bold, AppColor.primaryText),
        displaySmall: _textStyle(18, FontWeight.w600, AppColor.primaryText),
        headlineMedium: _textStyle(16, FontWeight.bold, AppColor.primaryText),
        bodyLarge: _textStyle(14, FontWeight.normal, AppColor.bodyText),
        bodyMedium: _textStyle(12, FontWeight.normal, AppColor.bodyText),
      ),
      cardTheme: CardThemeData(
        color: AppColor.whiteInputBg,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.whiteInputBg,
        labelStyle: TextStyle(
          color: AppColor.inputLabel,
          fontSize: ResponsiveHelper.fontSize(14, tabletSize: 16),
        ),
        hintStyle: TextStyle(
          color: AppColor.inputLabel,
          fontSize: ResponsiveHelper.fontSize(14, tabletSize: 16),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          borderSide: BorderSide(color: AppColor.inputLabel, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          borderSide: BorderSide(color: AppColor.inputLabel, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          borderSide: BorderSide(color: appColor, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: appColor,
          textStyle: TextStyle(
            fontSize: ResponsiveHelper.fontSize(16, tabletSize: 20),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          ),
          elevation: 2,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColor.primaryText),
      buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.light(primary: appColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
        ),
      ),
    );
  }

  // 🌙 Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: appColor,
      scaffoldBackgroundColor: AppColor.veryDark,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme.dark(
        primary: appColor,
        secondary: AppColor.secondary,
        surface: AppColor.veryDark,
        onSurface: Colors.grey[300]!,
        error: Colors.red,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.veryDark,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveHelper.fontSize(18, tabletSize: 22),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: _textStyle(24, FontWeight.bold, Colors.white),
        displayMedium: _textStyle(20, FontWeight.bold, Colors.white),
        displaySmall: _textStyle(18, FontWeight.w600, Colors.white),
        headlineMedium: _textStyle(16, FontWeight.bold, Colors.white),
        bodyLarge: TextStyle(
          fontSize: ResponsiveHelper.fontSize(14, tabletSize: 18),
          fontWeight: FontWeight.normal,
          color: Colors.grey[300],
        ),
        bodyMedium: TextStyle(
          fontSize: ResponsiveHelper.fontSize(12, tabletSize: 16),
          fontWeight: FontWeight.normal,
          color: Colors.grey[400],
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.grey[900],
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[850],
        labelStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: ResponsiveHelper.fontSize(14, tabletSize: 16),
        ),
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: ResponsiveHelper.fontSize(14, tabletSize: 16),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          borderSide: BorderSide(color: Colors.grey[600]!, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          borderSide: BorderSide(color: Colors.grey[600]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          borderSide: BorderSide(color: appColor, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: appColor,
          textStyle: TextStyle(
            fontSize: ResponsiveHelper.fontSize(16, tabletSize: 20),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.radius(8)),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}

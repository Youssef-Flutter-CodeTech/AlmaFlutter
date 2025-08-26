// utils/responsive_helper.dart
import 'package:alma_app/core/cubit/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResponsiveHelper {
  // 📏 Get logical screen width without BuildContext
  static double _getScreenWidth() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize.width / view.devicePixelRatio;
  }

  // 🌐 Is tablet? (logical width > 600 dp)
  static bool get isTablet {
    const kTabletBreakpoint = 600;
    return _getScreenWidth() > kTabletBreakpoint;
  }

  // 📱 Is mobile? (convenience)
  static bool get isMobile => !isTablet;

  // 🎨 Responsive font size: returns larger size on tablet
  static double fontSize(double mobileSize, {double? tabletSize}) {
    return isTablet ? (tabletSize ?? mobileSize * 1.3) : mobileSize;
  }

  // 📏 Responsive radius (for buttons, cards, etc.)
  static double radius(double baseRadius) {
    return isTablet ? baseRadius * 1.2 : baseRadius;
  }

  // 📏 Responsive padding/margin
  static double spacing(double mobile, {double? tablet}) {
    return isTablet ? (tablet ?? mobile * 1.2) : mobile;
  }

  // 🖥️ Optional: Use with context (e.g. in widgets)
  static bool isTabletWithContext(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width > 600;
  }
}

bool isTablet(BuildContext context) =>
    ResponsiveHelper.isTabletWithContext(context);

Color checkColor(
        {required BuildContext context,
        required Color lightColor,
        required Color darkColor}) =>
    context.read<ThemeCubit>().themeMode != ThemeMode.dark
        ? lightColor
        : darkColor;

double rSize(double mobile, {double? tablet}) =>
    ResponsiveHelper.fontSize(mobile, tabletSize: tablet);
double rRadius(double base) => ResponsiveHelper.radius(base);
double rSpacing(double mobile, {double? tablet}) =>
    ResponsiveHelper.spacing(mobile, tablet: tablet);

import 'package:alma_app/features/Auth/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import '../routing/routes.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/language/presentation/pages/language_preferences_page.dart';
import '../../features/Auth/forgetpassword/presentation/pages/forgetpassword_page.dart';
import '../../features/Auth/verifyotp/presentation/pages/verifyotp_page.dart';
import '../../features/settings/appearance/presentation/pages/appearance_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _createRoute(const SplashScreen());

      case Routes.loginScreen:
        return _createRoute(const LoginScreen());

      case Routes.forgetPasswordScreen:
        return _createRoute(const ForgetpasswordPage());

      case Routes.verifyOtpScreen:
        return _createRoute(const VerifyotpPage());

      case Routes.languagePreferences:
        return _createRoute(const LanguagePreferencesPage());

      case Routes.appearance:
        return _createRoute(const AppearancePage());

      default:
        return null;
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

import 'package:alma_app/core/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/routing/routes.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // After splash go to language selection first
      NavigationService.pushNamed(Routes.languagePreferences, arguments: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/images/splashscreen.svg",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          Positioned(
            top: 233,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/logo.png",
            ),
          ),
        ],
      ),
    );
  }
}

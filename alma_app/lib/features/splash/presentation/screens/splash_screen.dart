import 'package:alma_app/core/services/navigation_service.dart';
import 'package:alma_app/core/utils/background_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: backgroundImg(
        img: "assets/images/splashscreen.svg",
        items: Positioned(
          top: 233,
          left: 0,
          right: 0,
          child: Image.asset(
            width: 213.w,
            height: 86.h,
            "assets/images/alma.png",
          ),
        ),
      ),
    );
  }
}

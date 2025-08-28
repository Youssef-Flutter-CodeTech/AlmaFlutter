import 'package:alma_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final Widget? childwidget;

  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;

  final VoidCallback? onPressed;
  const AppButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.borderSideColor,
    this.childwidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(color: borderSideColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? appColor,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 0.w,
            vertical: verticalPadding?.h ?? 0.h,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth?.w ?? 350.w, buttonHeight ?? 44.h),
        ),
      ),
      onPressed: onPressed,
      child: childwidget ??
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
    );
  }
}

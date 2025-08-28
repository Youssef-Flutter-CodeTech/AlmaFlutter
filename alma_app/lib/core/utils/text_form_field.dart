import 'package:alma_app/core/constants/app_constants.dart';
import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Widget? preifxwidget;
  final bool? readonly;
  final Widget? preifIcon;
  final TextInputType? keyboard;
  final Function(String)? onchange;
  final Function(String)? onfieldsubmit;
  final TextEditingController? controller;
  final String title;
  final bool titleRequired;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const AppTextFormField({
    super.key,
    this.keyboard,
    this.readonly,
    this.preifxwidget,
    this.preifIcon,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.focusNode,
    this.onchange,
    this.onfieldsubmit,
    required this.title,
    this.titleRequired = true,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscureText ?? false;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyles.text14Regular?.copyWith(
                  color: checkColor(
                      context: context,
                      lightColor: AppColor.primaryText,
                      darkColor: AppColor.primaryText)),
            ),
            if (widget.titleRequired)
              Text(
                '*',
                style: TextStyles.text14Regular?.copyWith(
                    color: checkColor(
                        context: context,
                        lightColor: AppColor.error,
                        darkColor: AppColor.error)),
              ),
          ],
        ),
        verticalSpace(8),
        TextFormField(
          onFieldSubmitted: widget.onfieldsubmit,
          keyboardType: widget.keyboard,
          controller: widget.controller,
          onChanged: widget.onchange,
          focusNode: widget.focusNode,
          readOnly: widget.readonly ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            focusedBorder: widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: appColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(rRadius(4)),
                ),
            enabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.inputBorder,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(rRadius(4)),
                ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: appColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(rRadius(4)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: appColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(rRadius(4)),
            ),
            hintStyle: widget.hintStyle ??
                TextStyles.text14Regular?.copyWith(color: AppColor.inputLabel),
            hintText: widget.hintText,
            labelStyle: TextStyles.text14Regular?.copyWith(),
            prefixIcon: widget.preifIcon,
            prefix: widget.preifxwidget,
            suffixIcon: widget.isObscureText != null
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility_outlined,
                      color: AppColor.primaryText,
                    ),
                    onPressed: _toggleObscureText,
                  )
                : widget.suffixIcon,
            fillColor: widget.backgroundColor ??
                checkColor(
                    context: context,
                    lightColor: AppColor.bgWhite,
                    darkColor: AppColor.bodyText),
            filled: true,
          ),
          obscureText: _obscureText,
          style:
              TextStyles.text14Regular?.copyWith(color: AppColor.primaryText),
          validator: widget.validator,
        ),
      ],
    );
  }
}

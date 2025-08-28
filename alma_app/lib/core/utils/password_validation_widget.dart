import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/utils/validations.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordValidation extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;

  const PasswordValidation({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    final validations = <Widget>[];

    if (hasMinLength) {
      validations.add(_buildValidationRow(
        context,
        'auth.at_least_8_chars'.tr(),
        hasMinLength,
      ));
    }

    if (hasLowerCase) {
      validations.add(_buildValidationRow(
        context,
        'auth.one_lowercase'.tr(),
        hasLowerCase,
      ));
    }

    if (hasUpperCase) {
      validations.add(_buildValidationRow(
        context,
        'auth.one_uppercase'.tr(),
        hasUpperCase,
      ));
    }

    if (hasNumber) {
      validations.add(_buildValidationRow(
        context,
        'auth.one_number'.tr(),
        hasNumber,
      ));
    }

    if (hasSpecialCharacters) {
      validations.add(_buildValidationRow(
        context,
        'auth.one_special_char'.tr(),
        hasSpecialCharacters,
      ));
    }

    if (validations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'auth.password_requirements'.tr(),
          style: TextStyles.text14Medium?.copyWith(
            color: checkColor(
              context: context,
              lightColor: AppColor.primaryText,
              darkColor: AppColor.whiteInputBg,
            ),
          ),
        ),
        verticalSpace(8),
        ...validations,
      ],
    );
  }

  Widget _buildValidationRow(BuildContext context, String text, bool isValid) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 16.w,
            color: checkColor(
              context: context,
              lightColor: AppColor.green,
              darkColor: AppColor.green,
            ),
          ),
          horizontalSpace(8),
          Text(
            text,
            style: TextStyles.text12Regular?.copyWith(
              color: checkColor(
                context: context,
                lightColor: AppColor.green,
                darkColor: AppColor.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordValidationWidget extends StatefulWidget {
  final TextEditingController passController;

  const PasswordValidationWidget({
    super.key,
    required this.passController,
  });

  @override
  State<PasswordValidationWidget> createState() =>
      _PasswordValidationWidgetState();
}

class _PasswordValidationWidgetState extends State<PasswordValidationWidget> {
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    listenPasswordChanges();
    super.initState();
  }

  void listenPasswordChanges() {
    widget.passController.addListener(() {
      setState(() {
        hasLowerCase = Validations.hasLowerCase(widget.passController.text);
        hasUpperCase = Validations.hasUpperCase(widget.passController.text);
        hasSpecialCharacters =
            Validations.hasSpecialCharacter(widget.passController.text);
        hasNumber = Validations.hasNumber(widget.passController.text);
        hasMinLength = Validations.hasMinLength(widget.passController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: PasswordValidation(
        hasLowerCase: hasLowerCase,
        hasUpperCase: hasUpperCase,
        hasSpecialCharacters: hasSpecialCharacters,
        hasNumber: hasNumber,
        hasMinLength: hasMinLength,
      ),
    );
  }
}

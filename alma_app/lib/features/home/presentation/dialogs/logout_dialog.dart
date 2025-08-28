import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/routing/routes.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: checkColor(
        context: context,
        lightColor: AppColor.bgWhite,
        darkColor: AppColor.veryDark,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(rRadius(12)),
      ),
      title: Row(
        children: [
          Icon(
            Icons.logout,
            color: AppColor.red,
            size: 24,
          ),
          horizontalSpace(12),
          Text(
            'home.logout_title'.tr(),
            style: TextStyles.text16Bold?.copyWith(
              color: checkColor(
                context: context,
                lightColor: AppColor.primaryText,
                darkColor: AppColor.whiteInputBg,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        'home.logout_message'.tr(),
        style: TextStyles.text14Regular?.copyWith(
          color: checkColor(
            context: context,
            lightColor: AppColor.bodyText,
            darkColor: AppColor.whiteInputBg,
          ),
        ),
      ),
      actions: [
        _buildActionButton(
          context,
          'home.cancel'.tr(),
          AppColor.bodyText,
          () => Navigator.of(context).pop(),
        ),
        _buildActionButton(
          context,
          'home.logout'.tr(),
          AppColor.red,
          () => _handleLogout(context),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyles.text14Medium?.copyWith(
          color: color,
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    Navigator.of(context).pop(); // Close dialog
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.loginScreen,
      (route) => false,
    );
  }
}

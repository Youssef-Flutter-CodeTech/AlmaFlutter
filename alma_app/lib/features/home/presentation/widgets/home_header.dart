import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(rSpacing(16)),
      color: checkColor(
        context: context,
        lightColor: AppColor.bgWhite,
        darkColor: AppColor.veryDark,
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: checkColor(
                context: context,
                lightColor: AppColor.primaryText,
                darkColor: AppColor.whiteInputBg,
              ),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          horizontalSpace(16),
          Expanded(
            child: Row(
              children: [
                Text(
                  'Alma Travel',
                  style: TextStyles.text16Bold?.copyWith(
                    color: AppColor.red,
                  ),
                ),
                horizontalSpace(8),
                Text(
                  'بداخل badael',
                  style: TextStyles.text14Medium?.copyWith(
                    color: AppColor.green,
                  ),
                ),
              ],
            ),
          ),
          _buildBalanceDisplay(),
          horizontalSpace(12),
          _buildNotificationIcon(context),
        ],
      ),
    );
  }

  Widget _buildBalanceDisplay() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'SAR 2300',
        style: TextStyles.text14Medium?.copyWith(
          color: AppColor.bgWhite,
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.notifications,
          color: checkColor(
            context: context,
            lightColor: AppColor.primaryText,
            darkColor: AppColor.whiteInputBg,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColor.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

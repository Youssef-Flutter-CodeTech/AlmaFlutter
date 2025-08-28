import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BestDealsSection extends StatefulWidget {
  final String selectedTab;
  final Function(String) onTabChanged;

  const BestDealsSection({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  State<BestDealsSection> createState() => _BestDealsSectionState();
}

class _BestDealsSectionState extends State<BestDealsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: rSpacing(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home.best_deals_title'.tr(),
            style: TextStyles.text16Bold?.copyWith(
              color: checkColor(
                context: context,
                lightColor: AppColor.primaryText,
                darkColor: AppColor.whiteInputBg,
              ),
            ),
          ),
          verticalSpace(4),
          Text(
            'home.best_deals_subtitle'.tr(),
            style: TextStyles.text14Regular?.copyWith(
              color: checkColor(
                context: context,
                lightColor: AppColor.bodyText,
                darkColor: AppColor.whiteInputBg,
              ),
            ),
          ),
          verticalSpace(16),
          _buildTabBar(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        _buildTab('International', true),
        horizontalSpace(12),
        _buildTab('Domestic', false),
      ],
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => widget.onTabChanged(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.red : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColor.red : AppColor.inputBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyles.text14Medium?.copyWith(
            color: isSelected
                ? AppColor.bgWhite
                : checkColor(
                    context: context,
                    lightColor: AppColor.primaryText,
                    darkColor: AppColor.whiteInputBg,
                  ),
          ),
        ),
      ),
    );
  }
}

import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../dialogs/logout_dialog.dart';
import '../dialogs/delete_account_dialog.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.veryDark,
        ),
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _buildDrawerItems(context),
            ),
            _buildBottomActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(rSpacing(16)),
      decoration: BoxDecoration(
        color: checkColor(
          context: context,
          lightColor: AppColor.whiteInputBg,
          darkColor: AppColor.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(rSpacing(8)),
            decoration: BoxDecoration(
              color: AppColor.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  'بداخل',
                  style: TextStyles.text14Bold?.copyWith(
                    color: AppColor.red,
                  ),
                ),
                horizontalSpace(4),
                Text(
                  'badael',
                  style: TextStyles.text14Bold?.copyWith(
                    color: AppColor.red,
                  ),
                ),
              ],
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.company_profile'.tr(),
                  style: TextStyles.text14Medium?.copyWith(
                    color: checkColor(
                      context: context,
                      lightColor: AppColor.primaryText,
                      darkColor: AppColor.whiteInputBg,
                    ),
                  ),
                ),
                Text(
                  'Badael',
                  style: TextStyles.text12Regular?.copyWith(
                    color: checkColor(
                      context: context,
                      lightColor: AppColor.bodyText,
                      darkColor: AppColor.whiteInputBg,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: checkColor(
              context: context,
              lightColor: AppColor.bodyText,
              darkColor: AppColor.whiteInputBg,
            ),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context) {
    final sections = [
      {
        'title': 'home.employee'.tr(),
        'items': [
          {'icon': Icons.star, 'label': 'home.classification'},
          {'icon': Icons.verified_user, 'label': 'home.roles'},
          {'icon': Icons.account_tree, 'label': 'home.hierarchy'},
          {'icon': Icons.people, 'label': 'home.employees'},
          {'icon': Icons.business_center, 'label': 'home.cost_center'},
        ]
      },
      {
        'title': 'home.travel_management'.tr(),
        'items': [
          {'icon': Icons.security, 'label': 'home.travel_policy'},
          {'icon': Icons.work, 'label': 'home.trip_purpose'},
          {'icon': Icons.receipt, 'label': 'home.invoices'},
          {'icon': Icons.check_circle, 'label': 'home.approval_flow'},
          {'icon': Icons.security, 'label': 'home.travel_insurance'},
        ]
      },
      {
        'title': 'home.company'.tr(),
        'items': [
          {'icon': Icons.bar_chart, 'label': 'home.dashboard'},
          {'icon': Icons.monetization_on, 'label': 'home.expense_management'},
          {'icon': Icons.description, 'label': 'home.invoice_profile'},
          {'icon': Icons.pie_chart, 'label': 'home.reports'},
          {'icon': Icons.settings, 'label': 'home.budget_management'},
          {'icon': Icons.credit_card, 'label': 'home.payments'},
        ]
      },
      {
        'title': 'home.bookings'.tr(),
        'items': [
          {'icon': Icons.calendar_today, 'label': 'home.all_bookings'},
          {'icon': Icons.location_on, 'label': 'home.active_bookings'},
          {'icon': Icons.help, 'label': 'home.tickets'},
          {'icon': Icons.directions_car, 'label': 'home.ground_service'},
          {'icon': Icons.wifi_off, 'label': 'home.offline_bookings'},
        ]
      },
      {
        'title': 'home.support'.tr(),
        'items': [
          {'icon': Icons.help, 'label': 'home.help_center'},
          {'icon': Icons.headset_mic, 'label': 'home.customer_support'},
          {'icon': Icons.sos, 'label': 'home.sos'},
          {'icon': Icons.chat, 'label': 'home.live_chat'},
          {'icon': Icons.phone, 'label': 'home.contact_us'},
        ]
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return _buildSection(context, section);
      },
    );
  }

  Widget _buildSection(BuildContext context, Map<String, dynamic> section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSpacing(16),
            vertical: rSpacing(12),
          ),
          child: Text(
            section['title'].toString(),
            style: TextStyles.text14Bold?.copyWith(
              color: checkColor(
                context: context,
                lightColor: AppColor.primaryText,
                darkColor: AppColor.whiteInputBg,
              ),
            ),
          ),
        ),
        ...(section['items'] as List)
            .map((item) => _buildDrawerItem(context, item)),
        Divider(
          color: checkColor(
            context: context,
            lightColor: AppColor.inputBorder,
            darkColor: AppColor.bodyText,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context, Map<String, dynamic> item) {
    return ListTile(
      leading: Icon(
        item['icon'] as IconData,
        color: checkColor(
          context: context,
          lightColor: AppColor.bodyText,
          darkColor: AppColor.whiteInputBg,
        ),
        size: 20,
      ),
      title: Text(
        item['label'].toString().tr(),
        style: TextStyles.text14Regular?.copyWith(
          color: checkColor(
            context: context,
            lightColor: AppColor.primaryText,
            darkColor: AppColor.whiteInputBg,
          ),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: checkColor(
          context: context,
          lightColor: AppColor.bodyText,
          darkColor: AppColor.whiteInputBg,
        ),
        size: 16,
      ),
      onTap: () {
        // Handle navigation for each item
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(rSpacing(16)),
      child: Column(
        children: [
          _buildActionButton(
            context,
            'home.logout'.tr(),
            Icons.logout,
            AppColor.red,
            () => _showLogoutDialog(context),
          ),
          verticalSpace(12),
          _buildActionButton(
            context,
            'home.delete_account'.tr(),
            Icons.delete_forever,
            AppColor.error,
            () => _showDeleteAccountDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: AppColor.bgWhite),
        label: Text(
          label,
          style: TextStyles.text14Medium?.copyWith(
            color: AppColor.bgWhite,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: rSpacing(12)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const DeleteAccountDialog(),
    );
  }
}

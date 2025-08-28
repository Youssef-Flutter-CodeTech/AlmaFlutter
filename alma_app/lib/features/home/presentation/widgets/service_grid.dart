import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceGrid extends StatelessWidget {
  const ServiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'icon': Icons.flight, 'label': 'home.flights'},
      {'icon': Icons.hotel, 'label': 'home.hotels'},
      {'icon': Icons.directions_car, 'label': 'home.car_rental'},
      {'icon': Icons.train, 'label': 'home.trains'},
      {'icon': Icons.sailing, 'label': 'home.cruises'},
      {'icon': Icons.beach_access, 'label': 'home.holidays'},
      {'icon': Icons.credit_card, 'label': 'home.visa'},
      {'icon': Icons.security, 'label': 'home.insurance'},
      {'icon': Icons.sim_card, 'label': 'home.esim'},
    ];

    return Container(
      padding: EdgeInsets.all(rSpacing(16)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: rSpacing(16),
          mainAxisSpacing: rSpacing(16),
          childAspectRatio: 1.2,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return _buildServiceCard(context, service);
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    return Container(
      decoration: BoxDecoration(
        color: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.border,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: checkColor(
            context: context,
            lightColor: AppColor.inputBorder,
            darkColor: AppColor.bodyText,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            service['icon'] as IconData,
            color: AppColor.red,
            size: 32,
          ),
          verticalSpace(8),
          Text(
            service['label'].toString().tr(),
            style: TextStyles.text12Regular?.copyWith(
              color: checkColor(
                context: context,
                lightColor: AppColor.primaryText,
                darkColor: AppColor.whiteInputBg,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

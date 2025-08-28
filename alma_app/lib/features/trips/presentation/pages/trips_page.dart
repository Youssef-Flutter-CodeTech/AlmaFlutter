import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: checkColor(
        context: context,
        lightColor: AppColor.whiteInputBg,
        darkColor: AppColor.veryDark,
      ),
      appBar: AppBar(
        title: Text(
          'trips.title'.tr(),
          style: TextStyles.text16Bold?.copyWith(
            color: checkColor(
              context: context,
              lightColor: AppColor.primaryText,
              darkColor: AppColor.whiteInputBg,
            ),
          ),
        ),
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.veryDark,
        ),
        foregroundColor: checkColor(
          context: context,
          lightColor: AppColor.primaryText,
          darkColor: AppColor.whiteInputBg,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(rSpacing(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'trips.subtitle'.tr(),
              style: TextStyles.text16Regular?.copyWith(
                color: checkColor(
                  context: context,
                  lightColor: AppColor.bodyText,
                  darkColor: AppColor.whiteInputBg,
                ),
              ),
            ),
            verticalSpace(24),
            Expanded(
              child: _buildTripsList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsList(BuildContext context) {
    final trips = [
      {
        'title': 'Business Trip to Dubai',
        'destination': 'Dubai, UAE',
        'startDate': '2025-01-15',
        'endDate': '2025-01-20',
        'status': 'active',
        'cost': 2500.0,
      },
      {
        'title': 'Vacation in Istanbul',
        'destination': 'Istanbul, Turkey',
        'startDate': '2025-02-01',
        'endDate': '2025-02-07',
        'status': 'upcoming',
        'cost': 1800.0,
      },
    ];

    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return _buildTripCard(context, trip);
      },
    );
  }

  Widget _buildTripCard(BuildContext context, Map<String, dynamic> trip) {
    return Container(
      margin: EdgeInsets.only(bottom: rSpacing(16)),
      padding: EdgeInsets.all(rSpacing(16)),
      decoration: BoxDecoration(
        color: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.border,
        ),
        borderRadius: BorderRadius.circular(rRadius(12)),
        border: Border.all(
          color: checkColor(
            context: context,
            lightColor: AppColor.inputBorder,
            darkColor: AppColor.bodyText,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  trip['title'],
                  style: TextStyles.text16Bold?.copyWith(
                    color: checkColor(
                      context: context,
                      lightColor: AppColor.primaryText,
                      darkColor: AppColor.whiteInputBg,
                    ),
                  ),
                ),
              ),
              _buildStatusChip(trip['status']),
            ],
          ),
          verticalSpace(8),
          Text(
            trip['destination'],
            style: TextStyles.text14Regular?.copyWith(
              color: checkColor(
                context: context,
                lightColor: AppColor.bodyText,
                darkColor: AppColor.whiteInputBg,
              ),
            ),
          ),
          verticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SAR ${trip['cost']}',
                style: TextStyles.text16Bold?.copyWith(
                  color: AppColor.green,
                ),
              ),
              Text(
                '${trip['startDate']} - ${trip['endDate']}',
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
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    String statusText;

    switch (status) {
      case 'active':
        chipColor = AppColor.green;
        statusText = 'trips.status_active'.tr();
        break;
      case 'upcoming':
        chipColor = AppColor.darkBlue;
        statusText = 'trips.status_upcoming'.tr();
        break;
      default:
        chipColor = AppColor.bodyText;
        statusText = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: TextStyles.text12Regular?.copyWith(
          color: chipColor,
        ),
      ),
    );
  }
}

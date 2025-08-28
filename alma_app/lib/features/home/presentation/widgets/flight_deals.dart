import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class FlightDeals extends StatelessWidget {
  const FlightDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: EdgeInsets.symmetric(vertical: rSpacing(16)),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: rSpacing(16)),
        children: [
          _buildFlightCard(
            context,
            'Etihad',
            'Economy',
            'Monday, 19 May 2025',
            'Dammam',
            'Istanbul',
            'SAR 607',
          ),
          horizontalSpace(16),
          _buildFlightCard(
            context,
            'Air Arabia',
            'Economy',
            'Tuesday, 20 May 2025',
            'Jeddah',
            'Dubai',
            'SAR 350',
          ),
        ],
      ),
    );
  }

  Widget _buildFlightCard(
    BuildContext context,
    String airline,
    String class_,
    String date,
    String from,
    String to,
    String price,
  ) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(rSpacing(16)),
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
      child: Row(
        children: [
          Expanded(
            child: _buildFlightDetails(
              context,
              airline,
              class_,
              date,
              from,
              to,
            ),
          ),
          _buildFlightPriceAndArrow(context, price),
        ],
      ),
    );
  }

  Widget _buildFlightDetails(
    BuildContext context,
    String airline,
    String class_,
    String date,
    String from,
    String to,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          airline,
          style: TextStyles.text16Bold?.copyWith(
            color: AppColor.darkBlue,
          ),
        ),
        verticalSpace(4),
        Text(
          class_,
          style: TextStyles.text12Regular?.copyWith(
            color: checkColor(
              context: context,
              lightColor: AppColor.bodyText,
              darkColor: AppColor.whiteInputBg,
            ),
          ),
        ),
        verticalSpace(4),
        Text(
          date,
          style: TextStyles.text12Regular?.copyWith(
            color: checkColor(
              context: context,
              lightColor: AppColor.bodyText,
              darkColor: AppColor.whiteInputBg,
            ),
          ),
        ),
        verticalSpace(8),
        _buildRouteInfo(context, from, to),
      ],
    );
  }

  Widget _buildRouteInfo(BuildContext context, String from, String to) {
    return Row(
      children: [
        Text(
          from,
          style: TextStyles.text14Medium?.copyWith(
            color: checkColor(
              context: context,
              lightColor: AppColor.primaryText,
              darkColor: AppColor.whiteInputBg,
            ),
          ),
        ),
        horizontalSpace(8),
        Icon(
          Icons.swap_horiz,
          color: AppColor.red,
          size: 16,
        ),
        horizontalSpace(8),
        Text(
          to,
          style: TextStyles.text14Medium?.copyWith(
            color: checkColor(
              context: context,
              lightColor: AppColor.primaryText,
              darkColor: AppColor.whiteInputBg,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFlightPriceAndArrow(BuildContext context, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(
              Icons.flag,
              color: AppColor.green,
              size: 16,
            ),
            horizontalSpace(4),
            Text(
              price,
              style: TextStyles.text16Bold?.copyWith(
                color: AppColor.green,
              ),
            ),
          ],
        ),
        const Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          color: AppColor.red,
          size: 16,
        ),
      ],
    );
  }
}

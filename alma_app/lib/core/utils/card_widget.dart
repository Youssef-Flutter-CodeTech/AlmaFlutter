import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

Widget cardWidget({required BuildContext context, required Widget child}) =>
    Card(
      elevation: 3,
      color: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.border),
      child: child,
    );

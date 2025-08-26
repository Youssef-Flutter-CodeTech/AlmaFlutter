import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/color_palette.dart';
import '../widgets/mode_selector.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.inputLabel,
          darkColor: AppColor.veryDark),
      appBar: AppBar(
        title: Text('appearance.title'.tr()),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('appearance.theme_setup'.tr(),
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColorPalette(),
                    SizedBox(height: 16),
                    ModeSelector(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

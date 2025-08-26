import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/routing/routes.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/color_palette.dart';
import '../widgets/mode_selector.dart';

class AppearancePage extends StatelessWidget {
  final bool shownextButton;
  const AppearancePage({super.key, this.shownextButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.veryDark,
        ),
        centerTitle: false,
        title: Text(
          'appearance.title'.tr(),
          style: TextStyles.text14SemiBold?.copyWith(
              color: checkColor(
                  context: context,
                  lightColor: AppColor.primaryText,
                  darkColor: AppColor.inputLabel)),
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        color: checkColor(
          context: context,
          lightColor: AppColor.whiteInputBg,
          darkColor: AppColor.veryDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('appearance.theme_setup'.tr(),
                style: TextStyles.text16Bold?.copyWith(
                    color: checkColor(
                        context: context,
                        lightColor: AppColor.primaryText,
                        darkColor: AppColor.inputLabel))),
            const SizedBox(height: 12),
            Card(
              elevation: 3,
              color: checkColor(
                  context: context,
                  lightColor: AppColor.bgWhite,
                  darkColor: AppColor.bodyText),
              margin: EdgeInsets.zero,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColorPalette(),
                    SizedBox(height: 16),
                    ModeSelector(),
                    verticalSpace(20),
                    shownextButton
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.loginScreen);
                              },
                              child: Text('language.next'.tr()),
                            ),
                          )
                        : SizedBox()
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

import 'package:alma_app/core/cubit/theme/theme_cubit.dart';
import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/language_section.dart';

class LanguagePreferencesPage extends StatelessWidget {
  final bool shownextButton;
  const LanguagePreferencesPage({super.key, this.shownextButton = true});

  Color checkColor(
      {required BuildContext context,
      required Color lightColor,
      required Color darkColor}) {
    final ThemeMode mode = context.watch<ThemeCubit>().state;
    final isDark = mode == ThemeMode.system
        ? MediaQuery.of(context).platformBrightness == Brightness.dark
        : mode == ThemeMode.dark;
    return isDark ? darkColor : lightColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: checkColor(
        context: context,
        lightColor: AppColor.bgWhite,
        darkColor: AppColor.veryDark,
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          "language.languagetitle".tr(),
          style: TextStyles.text16Bold?.copyWith(
              color: checkColor(
            context: context,
            lightColor: AppColor.primaryText,
            darkColor: AppColor.bgWhite,
          )),
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.veryDark,
        ),
        foregroundColor: checkColor(
          context: context,
          lightColor: AppColor.veryDark,
          darkColor: Colors.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        color: checkColor(
          context: context,
          lightColor: AppColor.whiteInputBg,
          darkColor: AppColor.veryDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'language.preferences_title'.tr(),
              style: TextStyles.text16ExtraBold?.copyWith(
                color: checkColor(
                  context: context,
                  lightColor: AppColor.primaryText,
                  darkColor: AppColor.whiteInputBg,
                ),
              ),
            ),
            verticalSpace(8),
            Text(
              'language.preferences_subtitle'.tr(),
              style: TextStyles.text14Regular?.copyWith(
                color: checkColor(
                  context: context,
                  lightColor: AppColor.bodyText,
                  darkColor: AppColor.whiteInputBg,
                ),
              ),
            ),
            verticalSpace(20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: checkColor(
                      context: context,
                      lightColor: AppColor.bgWhite,
                      darkColor: AppColor.veryDark,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      LanguageSection(),
                      verticalSpace(20),
                      shownextButton
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.appearance);
                                },
                                child: Text('language.next'.tr()),
                              ),
                            )
                          : SizedBox(),
                      verticalSpace(12),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

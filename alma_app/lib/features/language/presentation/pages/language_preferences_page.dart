import 'package:alma_app/core/cubit/theme/theme_cubit.dart';
import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/language_tile.dart';
import '../../../../core/cubit/locale/locale_cubit.dart';
import '../../../../core/routing/routes.dart';

class LanguagePreferencesPage extends StatelessWidget {
  const LanguagePreferencesPage({super.key});

  // Helper function to select color based on theme mode
  Color checkColor({
    required BuildContext context,
    required Color lightColor,
    required Color darkColor,
  }) {
    final ThemeMode themeMode = context.watch<ThemeCubit>().state;
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    return themeMode == ThemeMode.system
        ? (platformBrightness == Brightness.dark ? darkColor : lightColor)
        : (themeMode == ThemeMode.dark ? darkColor : lightColor);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'language.preferences_title'.tr(),
                style: TextStyles.text28Bold?.copyWith(
                  color: checkColor(
                    context: context,
                    lightColor: AppColor.veryDark,
                    darkColor: AppColor.whiteInputBg,
                  ),
                ),
              ),
              verticalSpace(8),
              Text(
                'language.preferences_subtitle'.tr(),
                style: TextStyles.text16BoldRegular?.copyWith(
                  color: checkColor(
                    context: context,
                    lightColor: AppColor.veryDark,
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
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        // Language Selection Section
                        BlocBuilder<LocaleCubit, LocaleState>(
                          builder: (context, state) {
                            return _buildLanguageSection(context, state);
                          },
                        ),
                        const SizedBox(height: 20),
                        // Next Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.loginScreen);
                            },
                            child: Text('Next'.tr()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, LocaleState localeState) {
    final Locale currentLocale = localeState.locale;

    Widget buildLanguageTile({
      required String title,
      required String subtitle,
      required String flagEmoji,
      required Locale locale,
    }) {
      final bool isSelected = currentLocale.languageCode == locale.languageCode;
      return LanguageTile(
        title: title,
        subtitle: subtitle,
        flagAsset: flagEmoji,
        selected: isSelected,
        onTap: () => context.read<LocaleCubit>().changeLocale(locale),
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.bgWhite,
          darkColor: AppColor.veryDark,
        ),
        titleColor: checkColor(
          context: context,
          lightColor: AppColor.veryDark,
          darkColor: Colors.white,
        ),
        subtitleColor: checkColor(
          context: context,
          lightColor: AppColor.veryDark,
          darkColor: Colors.grey[400]!,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Language'.tr(),
          style: TextStyles.text16BoldRegular?.copyWith(
            color: checkColor(
              context: context,
              lightColor: AppColor.veryDark,
              darkColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        buildLanguageTile(
          title: 'language.english'.tr(),
          subtitle: 'language.english_native'.tr(),
          flagEmoji: 'assets/images/englishflag.svg',
          locale: const Locale('en'),
        ),
        buildLanguageTile(
          title: 'language.arabic'.tr(),
          subtitle: 'language.arabic_native'.tr(),
          flagEmoji: 'assets/images/arabicflag.svg',
          locale: const Locale('ar'),
        ),
      ],
    );
  }
}

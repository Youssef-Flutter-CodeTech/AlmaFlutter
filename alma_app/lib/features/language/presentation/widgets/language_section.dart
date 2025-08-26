import 'package:alma_app/core/cubit/theme/theme_cubit.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/cubit/locale/locale_cubit.dart';
import 'language_tile.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  Color _tone(BuildContext context, Color light, Color dark) {
    final ThemeMode mode = context.watch<ThemeCubit>().state;
    final Brightness sys = MediaQuery.of(context).platformBrightness;
    if (mode == ThemeMode.system) return sys == Brightness.dark ? dark : light;
    return mode == ThemeMode.dark ? dark : light;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        final Locale current = state.locale;

        LanguageTile buildTile(
            String titleKey, String nativeKey, String asset, Locale locale) {
          final bool selected = current.languageCode == locale.languageCode;
          return LanguageTile(
            title: titleKey.tr(),
            subtitle: nativeKey.tr(),
            flagAsset: asset,
            selected: selected,
            onTap: () => context.read<LocaleCubit>().changeLocale(locale),
            backgroundColor:
                _tone(context, AppColor.bgWhite, AppColor.veryDark),
            titleColor: _tone(context, AppColor.veryDark, Colors.white),
            subtitleColor: _tone(context, AppColor.bodyText, AppColor.veryDark),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTile('language.english', 'language.english_native',
                'assets/images/englishflag.svg', const Locale('en')),
            buildTile('language.arabic', 'language.arabic_native',
                'assets/images/arabicflag.svg', const Locale('ar')),
          ],
        );
      },
    );
  }
}

import 'package:alma_app/core/cubit/locale/locale_cubit.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:alma_app/features/language/presentation/widgets/language_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

LanguageTile buildTile(BuildContext context, LocaleCubit localeCubit,
    String titleKey, String nativeKey, String asset, Locale locale) {
  final bool selected =
      localeCubit.state.locale.languageCode == locale.languageCode;
  return LanguageTile(
    title: titleKey.tr(),
    subtitle: nativeKey.tr(),
    flagAsset: asset,
    selected: selected,
    onTap: () => localeCubit.changeLocale(locale),
    backgroundColor: checkColor(
        context: context,
        lightColor: AppColor.bgWhite,
        darkColor: AppColor.veryDark),
    titleColor: checkColor(
        context: context,
        lightColor: AppColor.veryDark,
        darkColor: Colors.white),
    subtitleColor: checkColor(
        context: context,
        lightColor: AppColor.bodyText,
        darkColor: AppColor.veryDark),
  );
}

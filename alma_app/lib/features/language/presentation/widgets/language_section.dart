import 'package:alma_app/features/language/presentation/widgets/build_title_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/cubit/locale/locale_cubit.dart';

class LanguageSection extends StatelessWidget {
  final LocaleCubit localeCubit;
  const LanguageSection({super.key, required this.localeCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTile(
            context,
            localeCubit,
            'language.english',
            'language.english_native',
            'assets/images/englishflag.svg',
            const Locale('en')),
        buildTile(
            context,
            localeCubit,
            'language.arabic',
            'language.arabic_native',
            'assets/images/arabicflag.svg',
            const Locale('ar')),
      ],
    );
  }
}

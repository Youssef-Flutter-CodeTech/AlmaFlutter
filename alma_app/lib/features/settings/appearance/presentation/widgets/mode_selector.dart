import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/cubit/theme/theme_cubit.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode from ThemeCubit
    ThemeMode themeMode = context.watch<ThemeCubit>().state;

    Widget buildTile({
      required IconData icon,
      required String labelKey,
      required bool selected,
      required VoidCallback onTap,
    }) {
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
                width: selected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
                const SizedBox(height: 6),
                Text(labelKey.tr()),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('appearance.mode'.tr(),
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        Row(
          children: [
            buildTile(
              icon: Icons.light_mode,
              labelKey: 'appearance.light',
              selected: themeMode == ThemeMode.light,
              onTap: () => context.read<ThemeCubit>().setTheme(ThemeMode.light),
            ),
            const SizedBox(width: 12),
            buildTile(
              icon: Icons.dark_mode,
              labelKey: 'appearance.dark',
              selected: themeMode == ThemeMode.dark,
              onTap: () => context.read<ThemeCubit>().setTheme(ThemeMode.dark),
            ),
            const SizedBox(width: 12),
            buildTile(
              icon: Icons.phone_iphone,
              labelKey: 'appearance.system',
              selected: themeMode == ThemeMode.system,
              onTap: () =>
                  context.read<ThemeCubit>().setTheme(ThemeMode.system),
            ),
          ],
        ),
      ],
    );
  }
}

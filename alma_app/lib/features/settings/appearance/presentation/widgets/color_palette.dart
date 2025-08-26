import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ColorPalette extends StatelessWidget {
  const ColorPalette({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      const Color(0xFFEF4137),
      const Color(0xFF0F6CBD),
      const Color(0xFF8A2BE2),
      const Color(0xFFFF7A00),
      const Color(0xFF0FAF9A),
      const Color(0xFF3BA1F2),
      const Color(0xFF3949AB),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('appearance.color_default'.tr(),
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors
              .map(
                (c) => Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

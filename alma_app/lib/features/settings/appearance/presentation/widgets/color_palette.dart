import 'package:alma_app/core/cubit/color/color_cubit.dart';
import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        Row(
          children: [
            Text(
              'appearance.color'.tr(),
              style: TextStyles.text14SemiBold?.copyWith(
                color: checkColor(
                  context: context,
                  lightColor: AppColor.primaryText,
                  darkColor: AppColor.inputBorder,
                ),
              ),
            ),
            Text(
              'appearance.default'.tr(),
              style: TextStyles.text14SemiBold?.copyWith(
                color: checkColor(
                  context: context,
                  lightColor: AppColor.bodyText,
                  darkColor: AppColor.whiteInputBg,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(12),
        BlocBuilder<PrimaryColorCubit, Color>(
          builder: (context, selectedColor) {
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: colors.map(
                (color) {
                  final isSelected = color == selectedColor;
                  return InkWell(
                    onTap: () {
                      context.read<PrimaryColorCubit>().setPrimaryColor(color);
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade300,
                          width: isSelected ? 4 : 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }
}

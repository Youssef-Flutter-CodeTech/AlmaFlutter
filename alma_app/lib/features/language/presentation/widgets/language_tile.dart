import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String flagAsset;
  final bool selected;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;

  const LanguageTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.flagAsset,
    required this.selected,
    required this.onTap,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColor.primary : Colors.grey.withOpacity(0.3),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(flagAsset),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.text16BoldRegular?.copyWith(
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyles.text12BoldRegular?.copyWith(
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Custom radio with check mark when selected
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColor.primary : Colors.grey,
                  width: 2,
                ),
                color: selected ? AppColor.primary : Colors.transparent,
              ),
              child: selected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

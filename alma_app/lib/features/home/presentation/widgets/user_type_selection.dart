import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class UserTypeSelection extends StatefulWidget {
  final String selectedUserType;
  final Function(String) onUserTypeChanged;

  const UserTypeSelection({
    super.key,
    required this.selectedUserType,
    required this.onUserTypeChanged,
  });

  @override
  State<UserTypeSelection> createState() => _UserTypeSelectionState();
}

class _UserTypeSelectionState extends State<UserTypeSelection> {
  @override
  Widget build(BuildContext context) {
    final userTypes = ['Business', 'Personal', 'Guest', 'LTA'];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: rSpacing(16),
        vertical: rSpacing(12),
      ),
      child: Row(
        children: userTypes.map((type) {
          final isSelected = widget.selectedUserType == type;
          return Expanded(
            child: _buildUserTypeItem(type, isSelected),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUserTypeItem(String type, bool isSelected) {
    return GestureDetector(
      onTap: () => widget.onUserTypeChanged(type),
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColor.red : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColor.red,
                size: 16,
              ),
            horizontalSpace(4),
            Text(
              type,
              style: TextStyles.text14Medium?.copyWith(
                color: isSelected
                    ? AppColor.red
                    : checkColor(
                        context: context,
                        lightColor: AppColor.bodyText,
                        darkColor: AppColor.whiteInputBg,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/forgetpassword_cubit.dart';
import '../widgets/forget_form.dart';

class ForgetpasswordPage extends StatelessWidget {
  const ForgetpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetpasswordCubit(),
      child: Scaffold(
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.whiteInputBg,
          darkColor: AppColor.veryDark,
        ),
        appBar: AppBar(
          scrolledUnderElevation: 0,
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
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.forgot_password'.tr(),
                style: TextStyles.text28Bold?.copyWith(
                  color: checkColor(
                    context: context,
                    lightColor: AppColor.primaryText,
                    darkColor: AppColor.whiteInputBg,
                  ),
                ),
              ),
              verticalSpace(4),
              Text(
                'auth.forgot_password_subtitle'.tr(),
                style: TextStyles.text16Regular?.copyWith(
                  color: checkColor(
                    context: context,
                    lightColor: AppColor.bodyText,
                    darkColor: AppColor.whiteInputBg,
                  ),
                ),
              ),
              verticalSpace(24),
              ForgetPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

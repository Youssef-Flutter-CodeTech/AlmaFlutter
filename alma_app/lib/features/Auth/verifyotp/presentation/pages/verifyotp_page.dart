import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/responsive_helper.dart';
import 'package:alma_app/core/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/verifyotp_cubit.dart';
import '../cubit/verifyotp_state.dart';
import '../widgets/otp_form.dart';

class VerifyotpPage extends StatelessWidget {
  final String email;
  final String source; // 'login' or 'forget_password'
  const VerifyotpPage({super.key, required this.email, required this.source});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyotpCubit(),
      child: Scaffold(
        backgroundColor: checkColor(
          context: context,
          lightColor: AppColor.whiteInputBg,
          darkColor: AppColor.veryDark,
        ),
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<VerifyotpCubit, VerifyotpState>(
            listener: (context, state) {
              if (state is VerifyotpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
              if (state is VerifyotpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('auth.verify_code'.tr())),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'auth.otp_title'.tr(),
                    style: TextStyles.text28Bold?.copyWith(
                      color: checkColor(
                        context: context,
                        lightColor: AppColor.primaryText,
                        darkColor: AppColor.whiteInputBg,
                      ),
                    ),
                  ),
                  verticalSpace(4),
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        'auth.otp_subtitle'.tr(),
                        style: TextStyles.text16Regular?.copyWith(
                          color: checkColor(
                            context: context,
                            lightColor: AppColor.bodyText,
                            darkColor: AppColor.whiteInputBg,
                          ),
                        ),
                      ),
                      Text(
                        Validations.maskEmail(email),
                        style: TextStyles.text16Regular?.copyWith(
                          color: checkColor(
                            context: context,
                            lightColor: AppColor.bodyText,
                            darkColor: AppColor.whiteInputBg,
                          ),
                        ),
                      ),

                      //maskEmail
                    ],
                  ),
                  const SizedBox(height: 24),
                  OtpForm(source: source),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

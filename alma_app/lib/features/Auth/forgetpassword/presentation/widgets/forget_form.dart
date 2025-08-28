import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/button_widget.dart';
import 'package:alma_app/core/utils/card_widget.dart';
import 'package:alma_app/core/utils/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/utils/validations.dart';
import '../../../../../core/routing/routes.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: cardWidget(
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            children: [
              AppTextFormField(
                controller: _emailController,
                keyboard: TextInputType.emailAddress,
                hintText: 'name@company.com',
                validator: (v) => v != null && Validations.isEmailValid(v)
                    ? null
                    : 'auth.invalid_email'.tr(),
                title: 'auth.work_email'.tr(),
              ),
              verticalSpace(30),
              SizedBox(
                  height: 48,
                  child: AppButton(
                    buttonText: 'auth.send'.tr(),
                    textStyle: TextStyles.text16SemiBold!
                        .copyWith(color: AppColor.bgWhite),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // navigate to OTP screen with source
                        Navigator.of(context).pushNamed(Routes.verifyOtpScreen,
                            arguments: {
                              'email': _emailController.text,
                              'source': 'forget_password'
                            });
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

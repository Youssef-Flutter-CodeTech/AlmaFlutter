import 'package:alma_app/core/constants/app_constants.dart';
import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/card_widget.dart';
import 'package:alma_app/core/utils/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/utils/validations.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../../../../../core/routing/routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return cardWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Form(
              key: _formKey,
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
                  verticalSpace(16),
                  AppTextFormField(
                    controller: _passwordController,
                    isObscureText: true,
                    validator: (v) => (v != null && v.isNotEmpty)
                        ? null
                        : 'auth.required'.tr(),
                    hintText: 'auth.enterpassword'.tr(),
                    title: 'auth.password'.tr(),
                  ),
                  verticalSpace(20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(Routes.forgetPasswordScreen),
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'auth.forgot_password_q'.tr(),
                              style: TextStyles.text14Medium?.copyWith(
                                  decorationColor: appColor, color: appColor),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: appColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(26),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<LoginCubit>().login(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }
                            },
                      child: state is LoginLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(
                              'auth.login_cta'.tr(),
                              style: TextStyles.text16SemiBold,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          context: context,
        );
      },
    );
  }
}

import 'package:alma_app/core/extensions/sizedbox_extensions.dart';
import 'package:alma_app/core/theme/app_colors.dart';
import 'package:alma_app/core/theme/text_styles.dart';
import 'package:alma_app/core/utils/button_widget.dart';
import 'package:alma_app/core/utils/card_widget.dart';
import 'package:alma_app/core/utils/text_form_field.dart';
import 'package:alma_app/core/utils/validations.dart';
import 'package:alma_app/core/utils/password_validation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/set_new_password_cubit.dart';
import '../../../../../core/routing/routes.dart';

class SetNewPasswordForm extends StatefulWidget {
  const SetNewPasswordForm({super.key});

  @override
  State<SetNewPasswordForm> createState() => _SetNewPasswordFormState();
}

class _SetNewPasswordFormState extends State<SetNewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetNewPasswordCubit, SetNewPasswordState>(
      listener: (context, state) {
        if (state is SetNewPasswordSuccess) {
          _showSuccessMessage(context);
          _navigateToLogin(context);
        } else if (state is SetNewPasswordFailure) {
          _showErrorMessage(context, state.message);
        }
      },
      child: Form(
        key: _formKey,
        child: cardWidget(
          context: context,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              children: [
                AppTextFormField(
                  controller: _newPasswordController,
                  keyboard: TextInputType.visiblePassword,
                  hintText: 'auth.enter_password'.tr(),
                  validator: _validateNewPassword,
                  title: 'auth.new_password'.tr(),
                  isObscureText: true,
                ),
                verticalSpace(8),
                PasswordValidationWidget(
                  passController: _newPasswordController,
                ),
                verticalSpace(16),
                AppTextFormField(
                  controller: _confirmPasswordController,
                  keyboard: TextInputType.visiblePassword,
                  hintText: 'auth.enter_password'.tr(),
                  validator: _validateConfirmPassword,
                  title: 'auth.confirm_password'.tr(),
                  isObscureText: true,
                ),
                verticalSpace(30),
                BlocBuilder<SetNewPasswordCubit, SetNewPasswordState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 48,
                      child: AppButton(
                        buttonText: state is SetNewPasswordLoading
                            ? 'auth.processing'.tr()
                            : 'auth.reset_password'.tr(),
                        textStyle: TextStyles.text16SemiBold!
                            .copyWith(color: AppColor.bgWhite),
                        onPressed: state is SetNewPasswordLoading
                            ? null
                            : _handleSubmit,
                        childwidget: state is SetNewPasswordLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.bgWhite,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.password_required'.tr();
    }
    if (!Validations.hasMinLength(value)) {
      return 'auth.password_min_length'.tr();
    }
    if (!Validations.hasLowerCase(value)) {
      return 'auth.password_lowercase'.tr();
    }
    if (!Validations.hasUpperCase(value)) {
      return 'auth.password_uppercase'.tr();
    }
    if (!Validations.hasNumber(value)) {
      return 'auth.password_number'.tr();
    }
    if (!Validations.hasSpecialCharacter(value)) {
      return 'auth.one_special_char'.tr();
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.confirm_password_required'.tr();
    }
    if (value != _newPasswordController.text) {
      return 'auth.passwords_not_match'.tr();
    }
    return null;
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SetNewPasswordCubit>().setNewPassword(
            _newPasswordController.text,
            _confirmPasswordController.text,
          );
    }
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('auth.password_reset_success'.tr()),
        backgroundColor: AppColor.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    // Navigate to login page and clear the navigation stack
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.loginScreen,
      (route) => false,
    );
  }
}

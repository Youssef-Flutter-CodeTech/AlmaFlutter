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
      child: ListView(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'auth.work_email'.tr()),
            keyboardType: TextInputType.emailAddress,
            validator: (v) => v != null && Validations.isEmailValid(v)
                ? null
                : 'auth.invalid_email'.tr(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // navigate to OTP screen
                  Navigator.of(context).pushNamed(Routes.verifyOtpScreen);
                }
              },
              child: Text('auth.send'.tr()),
            ),
          ),
        ],
      ),
    );
  }
}

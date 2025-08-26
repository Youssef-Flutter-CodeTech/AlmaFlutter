import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/verifyotp_cubit.dart';
import '../widgets/otp_form.dart';

class VerifyotpPage extends StatelessWidget {
  const VerifyotpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyotpCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text('auth.otp_title'.tr())),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('auth.otp_subtitle'.tr()),
                  const SizedBox(height: 16),
                  const Expanded(child: OtpForm()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

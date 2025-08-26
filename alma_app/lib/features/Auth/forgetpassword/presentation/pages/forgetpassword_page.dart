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
        appBar: AppBar(title: Text('auth.reset_title'.tr())),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('auth.reset_subtitle'.tr()),
                  const SizedBox(height: 16),
                  const Expanded(child: ForgetPasswordForm()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

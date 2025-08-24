import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/verifyotp_cubit.dart';
import '../cubit/verifyotp_state.dart';

class VerifyotpPage extends StatelessWidget {
  const VerifyotpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyotpCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Verifyotp Page')),
        body: BlocBuilder<VerifyotpCubit, VerifyotpState>(
          builder: (context, state) {
            if (state is VerifyotpLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VerifyotpFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('Verifyotp Page'));
          },
        ),
      ),
    );
  }
}

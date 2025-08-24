import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/singup_cubit.dart';
import '../cubit/singup_state.dart';

class SingupPage extends StatelessWidget {
  const SingupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SingupCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Singup Page')),
        body: BlocBuilder<SingupCubit, SingupState>(
          builder: (context, state) {
            if (state is SingupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingupFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('Singup Page'));
          },
        ),
      ),
    );
  }
}

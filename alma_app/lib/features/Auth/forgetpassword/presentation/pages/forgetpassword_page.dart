import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/forgetpassword_cubit.dart';
import '../cubit/forgetpassword_state.dart';

class ForgetpasswordPage extends StatelessWidget {
  const ForgetpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetpasswordCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgetpassword Page')),
        body: BlocBuilder<ForgetpasswordCubit, ForgetpasswordState>(
          builder: (context, state) {
            if (state is ForgetpasswordLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ForgetpasswordFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('Forgetpassword Page'));
          },
        ),
      ),
    );
  }
}

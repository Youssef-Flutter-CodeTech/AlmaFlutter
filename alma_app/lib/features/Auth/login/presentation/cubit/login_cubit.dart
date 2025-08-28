import 'dart:async';

import 'package:alma_app/core/routing/routes.dart';
import 'package:alma_app/core/services/navigation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      Timer(Duration(seconds: 1), () {
        emit(LoginSuccess());
        NavigationService.pushNamed(
          Routes.verifyOtpScreen,
          arguments: {
            'email': email,
            'source': 'login', // or 'forget_password' depending on the flow
          },
        );
      });

      // Call usecase
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}

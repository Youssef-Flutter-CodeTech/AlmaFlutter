import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> doSomething() async {
    emit(LoginLoading());
    try {
      // Call usecase
      // emit(LoginSuccess(result));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}

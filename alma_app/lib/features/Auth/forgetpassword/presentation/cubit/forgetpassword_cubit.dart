import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgetpassword_state.dart';

class ForgetpasswordCubit extends Cubit<ForgetpasswordState> {
  ForgetpasswordCubit() : super(ForgetpasswordInitial());

  Future<void> doSomething() async {
    emit(ForgetpasswordLoading());
    try {
      // Call usecase
      // emit(ForgetpasswordSuccess(result));
    } catch (e) {
      emit(ForgetpasswordFailure(e.toString()));
    }
  }
}

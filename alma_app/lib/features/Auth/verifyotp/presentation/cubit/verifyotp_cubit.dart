import 'package:flutter_bloc/flutter_bloc.dart';
import 'verifyotp_state.dart';

class VerifyotpCubit extends Cubit<VerifyotpState> {
  VerifyotpCubit() : super(VerifyotpInitial());

  Future<void> doSomething() async {
    emit(VerifyotpLoading());
    try {
      // Call usecase
      // emit(VerifyotpSuccess(result));
    } catch (e) {
      emit(VerifyotpFailure(e.toString()));
    }
  }
}

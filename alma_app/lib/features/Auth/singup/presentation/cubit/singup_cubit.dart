import 'package:flutter_bloc/flutter_bloc.dart';
import 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit() : super(SingupInitial());

  Future<void> doSomething() async {
    emit(SingupLoading());
    try {
      // Call usecase
      // emit(SingupSuccess(result));
    } catch (e) {
      emit(SingupFailure(e.toString()));
    }
  }
}

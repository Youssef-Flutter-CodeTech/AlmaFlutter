import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/set_new_password_entity.dart';
import '../../domain/usecases/set_new_password_usecase.dart';

part 'set_new_password_state.dart';

class SetNewPasswordCubit extends Cubit<SetNewPasswordState> {
  final SetNewPasswordUseCase _setNewPasswordUseCase;

  SetNewPasswordCubit(this._setNewPasswordUseCase) : super(SetNewPasswordInitial());

  Future<void> setNewPassword(String newPassword, String confirmPassword) async {
    emit(SetNewPasswordLoading());
    
    try {
      final entity = SetNewPasswordEntity(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      
      final result = await _setNewPasswordUseCase(entity);
      
      if (result) {
        emit(SetNewPasswordSuccess());
      } else {
        emit(const SetNewPasswordFailure('Failed to set new password'));
      }
    } catch (e) {
      emit(SetNewPasswordFailure(e.toString()));
    }
  }

  void resetState() {
    emit(SetNewPasswordInitial());
  }
}

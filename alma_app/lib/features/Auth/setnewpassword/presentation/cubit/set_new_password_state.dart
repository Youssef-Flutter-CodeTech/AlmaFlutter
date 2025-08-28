part of 'set_new_password_cubit.dart';

abstract class SetNewPasswordState extends Equatable {
  const SetNewPasswordState();

  @override
  List<Object> get props => [];
}

class SetNewPasswordInitial extends SetNewPasswordState {}

class SetNewPasswordLoading extends SetNewPasswordState {}

class SetNewPasswordSuccess extends SetNewPasswordState {}

class SetNewPasswordFailure extends SetNewPasswordState {
  final String message;

  const SetNewPasswordFailure(this.message);

  @override
  List<Object> get props => [message];
}

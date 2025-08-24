abstract class SingupState {}

class SingupInitial extends SingupState {}

class SingupLoading extends SingupState {}

class SingupSuccess extends SingupState {
  // final result;
  // Success(this.result);
}

class SingupFailure extends SingupState {
  final String error;
  SingupFailure(this.error);
}

abstract class ForgetpasswordState {}

class ForgetpasswordInitial extends ForgetpasswordState {}

class ForgetpasswordLoading extends ForgetpasswordState {}

class ForgetpasswordSuccess extends ForgetpasswordState {
  // final result;
  // Success(this.result);
}

class ForgetpasswordFailure extends ForgetpasswordState {
  final String error;
  ForgetpasswordFailure(this.error);
}

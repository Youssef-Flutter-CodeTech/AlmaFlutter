abstract class VerifyotpState {}

class VerifyotpInitial extends VerifyotpState {}

class VerifyotpLoading extends VerifyotpState {}

class VerifyotpSuccess extends VerifyotpState {
  // final result;
  // Success(this.result);
}

class VerifyotpFailure extends VerifyotpState {
  final String error;
  VerifyotpFailure(this.error);
}

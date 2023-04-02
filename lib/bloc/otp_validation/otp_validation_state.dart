part of 'otp_validation_bloc.dart';

abstract class OtpvalidationState {}

class LoginInitial extends OtpvalidationState {}

class OtpvalidationLoad extends OtpvalidationState {}

class OtpvalidationDone extends OtpvalidationState {
  final LoginResponse response;

  OtpvalidationDone(this.response);
}

class OtpvalidationError extends OtpvalidationState {
  final String error;

  OtpvalidationError(this.error);
}

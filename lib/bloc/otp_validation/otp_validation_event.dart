part of 'otp_validation_bloc.dart';

abstract class OtpvalidationEvent {}

class OtpvalidationRequestEvent extends OtpvalidationEvent {
  final OtpvalidationRequest otpvalidationRequest;

  OtpvalidationRequestEvent(this.otpvalidationRequest);
}

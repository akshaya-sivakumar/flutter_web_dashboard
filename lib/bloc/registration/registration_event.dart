part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class RegistrationRequestEvent extends RegistrationEvent {
  final RegistrationRequest registrationRequest;

  RegistrationRequestEvent(this.registrationRequest);
}

class AgreeEvent extends RegistrationEvent {
  final bool agree;

  AgreeEvent(this.agree);
}

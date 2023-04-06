part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class RegistrationRequestEvent extends RegistrationEvent {
  final RegistrationRequest registrationRequest;

  RegistrationRequestEvent(this.registrationRequest);
}



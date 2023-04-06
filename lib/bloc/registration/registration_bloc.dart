import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/registration_request.dart';
import '../../model/registration_response.dart';
import '../../repo/registration_repo.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationRequestEvent>((event, emit) async {
      emit(RegistrationLoad());
      try {
        var response = await RegistrationRepository()
            .registration(event.registrationRequest);
        emit(RegistrationDone(response));
      } catch (e) {
        emit(RegistrationError(e.toString()));
      }
    });
  }
}

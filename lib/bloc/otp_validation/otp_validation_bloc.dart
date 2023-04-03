import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/login_request.dart';
import '../../model/login_response.dart';
import '../../repo/login_repo.dart';
import '../../utils/app_utils.dart';

part 'otp_validation_event.dart';
part 'otp_validation_state.dart';

class OtpvalidationBloc extends Bloc<OtpvalidationEvent, OtpvalidationState> {
  OtpvalidationBloc() : super(LoginInitial()) {
    on<OtpvalidationRequestEvent>((event, emit) async {
      emit(OtpvalidationLoad());
      try {
        LoginResponse response =
            await OtpvalidationRepository().login(event.otpvalidationRequest);
        AppUtils().storeLogin(response.response.data.JSESSIONID);
        emit(OtpvalidationDone(response));
      } catch (e) {
        emit(OtpvalidationError(e.toString()));
      }
    });
  }
}

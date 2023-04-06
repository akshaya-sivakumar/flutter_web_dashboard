import 'dart:convert';
import 'dart:core';

import '../constants/api_url.dart';
import '../model/login/login_request.dart';
import '../model/login/login_response.dart';
import '../resources/api_base_helper.dart';

class OtpvalidationRepository {
  Future<LoginResponse> login(OtpvalidationRequest product) async {
    var response = await ApiBaseHelper()
        .postMethod(ApiUrls.loginUrl, json.encode(product));

    LoginResponse regResponse =
        LoginResponse.fromJson(json.decode(response.body));
    if (regResponse.response.infoID == "EGN002") {
      throw "${json.decode(response.body)["response"]["infoMsg"]}";
    }
    return regResponse;
  }
}

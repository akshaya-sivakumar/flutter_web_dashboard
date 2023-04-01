import 'dart:convert';
import 'dart:core';

import '../constants/api_url.dart';
import '../model/registration_request.dart';
import '../model/registration_response.dart';
import '../resources/api_base_helper.dart';



class RegistrationRepository {
  Future<RegistrationResponse> registration(RegistrationRequest product) async {
    var response =
        await ApiBaseHelper().postMethod(ApiUrls.regUrl, json.encode(product));

    RegistrationResponse regResponse =
        RegistrationResponse.fromJson(json.decode(response.body));
    if (regResponse.response.infoID == "EGN002") {
      throw "${json.decode(response.body)["response"]["infoMsg"]}";
    }
    return regResponse;
  }
}

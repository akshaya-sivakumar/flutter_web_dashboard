import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<http.Response> postMethod(String url, String request) async {
    var response = await http.post(Uri.parse(url),
        headers: {"X-ENCRYPT": "false"}, body: request);

    handleResponse(response);
    return response;
  }

  void handleResponse(http.Response response) {
    if (response.statusCode != 200) {
      logError(response.request.toString(), response.body);
      throw "${response.statusCode} error";
    } else {
      logSuccess(response.request.toString(), response.body);
    }
  }

  Future<http.Response> getMethod(String url) async {
    var response = await http.get(Uri.parse(url));
    handleResponse(response);
    return response;
  }

  void logSuccess(String logName, dynamic msg) {
    log('\x1B[32m$logName $msg\x1B[0m');
  }

  void logError(String logName, dynamic msg) {
    log('\x1B[31m$logName $msg\x1B[0m');
  }
}

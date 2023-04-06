class LoginResponse {
  LoginResponse({
    required this.response,
  });
  late final Response response;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    response = Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['response'] = response.toJson();
    return data;
  }
}

class Response {
  Response({
    required this.infoID,
    required this.data,
    required this.msgID,
  });
  late final String infoID;
  late final Data data;
  late final String msgID;

  Response.fromJson(Map<String, dynamic> json) {
    infoID = json['infoID'];
    data = Data.fromJson(json['data']);
    msgID = json['msgID'];
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['infoID'] = infoID;
    datas['data'] = data.toJson();
    datas['msgID'] = msgID;
    return datas;
  }
}

class Data {
  Data({
    required this.jsessionid,
    required this.loginCount,
    required this.url,
  });
  late final String jsessionid;
  late final String loginCount;
  late final String url;

  Data.fromJson(Map<String, dynamic> json) {
    jsessionid = json['JSESSIONID'] ?? "";
    loginCount = json['loginCount'] ?? "";
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['JSESSIONID'] = jsessionid;
    data['loginCount'] = loginCount;
    data['url'] = url;
    return data;
  }
}

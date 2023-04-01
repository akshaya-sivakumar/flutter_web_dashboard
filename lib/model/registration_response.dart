class RegistrationResponse {
  RegistrationResponse({
    required this.response,
  });
  late final Response response;

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
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
    required this.infoMsg,
    required this.msgID,
  });
  late final String infoID;
  late final Data data;
  late final String infoMsg;
  late final String msgID;

  Response.fromJson(Map<String, dynamic> json) {
    infoID = json['infoID'];
    data = Data.fromJson(json['data']);
    infoMsg = json['infoMsg'];
    msgID = json['msgID'];
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['infoID'] = infoID;
    datas['data'] = data.toJson();
    datas['infoMsg'] = infoMsg;
    datas['msgID'] = msgID;
    return datas;
  }
}

class Data {
  Data();

  Data.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }
}

class OtpvalidationRequest {
  OtpvalidationRequest({
    required this.request,
  });
  late final Request request;

  OtpvalidationRequest.fromJson(Map<String, dynamic> json) {
    request = Request.fromJson(json['request']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['request'] = request.toJson();
    return data;
  }
}

class Request {
  Request({
    required this.data,
    required this.appID,
  });
  late final Data data;
  late final String appID;

  Request.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    appID = json['appID'];
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['data'] = data.toJson();
    datas['appID'] = appID;
    return datas;
  }
}

class Data {
  Data({
    required this.mobNo,
    required this.userType,
    required this.otp,
  });
  late final String mobNo;
  late final String userType;
  late final String otp;

  Data.fromJson(Map<String, dynamic> json) {
    mobNo = json['mobNo'];
    userType = json['userType'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mobNo'] = mobNo;
    data['userType'] = userType;
    data['otp'] = otp;
    return data;
  }
}

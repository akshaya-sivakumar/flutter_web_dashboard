import 'dart:math';

import 'package:flutter_dashboard_web/constants/app_constants.dart';

class WatchlistModel {
  WatchlistModel({
    required this.response,
  });
  late final Response response;

  WatchlistModel.fromJson(Map<String, dynamic> json) {
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
    required this.appID,
    required this.data,
  });
  late final String appID;
  late final Data data;

  Response.fromJson(Map<String, dynamic> json) {
    appID = json['appID'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['appID'] = appID;
    datas['data'] = data.toJson();
    return datas;
  }
}

class Data {
  Data({
    required this.symbols,
  });
  List<Symbols> symbols = [];

  Data.fromJson(Map<String, dynamic> json) {
    symbols =
        List.from(json['symbols']).map((e) => Symbols.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['symbols'] = symbols.map((e) => e.toJson()).toList();
    return data;
  }
}

class Symbols {
  Symbols(
      {required this.baseSym,
      required this.companyName,
      required this.dispSym,
      required this.excToken,
      required this.change,
      required this.changePer,
      required this.mCap,
      required this.sector,
      required this.sym,
      required this.ttEligibility,
      required this.watchlistName});
  late final String baseSym;
  late final String companyName;
  late final String dispSym;
  late final String excToken;
  late final String change;
  late final String changePer;
  late final String mCap;
  late final String sector;
  late final Sym sym;
  late final bool ttEligibility;
  late final String watchlistName;
  Random random = Random();

  Symbols.fromJson(Map<String, dynamic> json) {
    watchlistName =
        json["watchlistName"] ?? AppConstants.myListData[random.nextInt(4)];
    baseSym = json['baseSym'];
    companyName = json['companyName'];
    dispSym = json['dispSym'];
    excToken = json['excToken'];
    change = json["change"] ??
        (random.nextDouble() * 100 - 50.25).toStringAsFixed(2);
    changePer = json["changePer"] ??
        (random.nextDouble() * 100 - 50.25).toStringAsFixed(2);
    mCap = json['mCap'];
    sector = json['sector'];
    sym = Sym.fromJson(json['sym']);
    ttEligibility = json['tt_eligibility'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['baseSym'] = baseSym;
    data['companyName'] = companyName;
    data['dispSym'] = dispSym;
    data['excToken'] = excToken;
    data['change'] = change;
    data['changePer'] = changePer;
    data['mCap'] = mCap;
    data['sector'] = sector;
    data['sym'] = sym.toJson();
    data['tt_eligibility'] = ttEligibility;
    data["watchlistName"] = watchlistName;
    return data;
  }
}

class Sym {
  Sym({
    required this.asset,
    required this.exc,
    required this.expiry,
    required this.id,
    required this.instrument,
    required this.lotSize,
    required this.multiplier,
    required this.optionType,
    required this.streamSym,
    required this.strike,
    required this.tickSize,
  });
  late final String asset;
  late final String exc;
  late final String expiry;
  late final String id;
  late final String instrument;
  late final String lotSize;
  late final String multiplier;
  late final String optionType;
  late final String streamSym;
  late final String strike;
  late final String tickSize;

  Sym.fromJson(Map<String, dynamic> json) {
    asset = json['asset'];
    exc = json['exc'];
    expiry = json['expiry'];
    id = json['id'];
    instrument = json['instrument'];
    lotSize = json['lotSize'];
    multiplier = json['multiplier'];
    optionType = json['optionType'];
    streamSym = json['streamSym'];
    strike = json['strike'];
    tickSize = json['tickSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['asset'] = asset;
    data['exc'] = exc;
    data['expiry'] = expiry;
    data['id'] = id;
    data['instrument'] = instrument;
    data['lotSize'] = lotSize;
    data['multiplier'] = multiplier;
    data['optionType'] = optionType;
    data['streamSym'] = streamSym;
    data['strike'] = strike;
    data['tickSize'] = tickSize;
    return data;
  }
}

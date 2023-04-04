import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/model/watchlist_model.dart';

class AppUtils {
  bool isLoginned() {
    return (window.sessionStorage["login"] != null &&
            window.sessionStorage["login"] != "")
        ? true
        : false;
    // return true;
  }

  storeLogin(String sessionid) {
    window.sessionStorage["login"] = sessionid;
  }

  clearsession() {
    window.sessionStorage["login"] = "";
  }

  storeWatchlist(List<Symbols> symbols) {
    window.localStorage["watchlist"] = json.encode(symbols);
  }

  List<Symbols> getWatchlist() {
    List data = json.decode(window.localStorage["watchlist"] ?? "[]");

    return data.map((e) => Symbols.fromJson(e)).toList();
  }
}

extension StringExtension on String {
  double textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}

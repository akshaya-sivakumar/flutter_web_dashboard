import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/model/watchlist_model.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../auto_route/router.gr.dart';
import '../constants/app_constants.dart';
import '../constants/app_routes.dart';
import '../constants/appwidget_size.dart';
import '../main.dart';
import '../ui/widgets/text_widget.dart';

class AppUtils {
  static bool isDarktheme = false;

  bool isLoginned() {
    return (window.sessionStorage["login"] != null &&
            window.sessionStorage["login"] != "")
        ? true
        : false;
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

  logoutDialog(context, {bool fromNavigation = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return PointerInterceptor(
          intercepting: true,
          child: AlertDialog(
              title: TextWidget(
                AppConstants.confirmLogout,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: AppWidgetSize.dimen_16,
                    fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    AppConstants.logoutStatement,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: AppWidgetSize.dimen_14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: AppWidgetSize.dimen_20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: AppWidgetSize.dimen_10,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          AppUtils().clearsession();
                          appRoute.replaceAll([const Registration()]);
                        },
                        child: TextWidget(
                          AppConstants.logout,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(
                        width: AppWidgetSize.dimen_15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).canvasColor,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: AppWidgetSize.dimen_10,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          appRoute.pop();
                          if (fromNavigation) {
                            appRoute.pushNamed(AppRoutes.watchlistRoute);
                          }
                        },
                        child: TextWidget(
                          AppConstants.cancel,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  )
                ],
              )),
        );
      },
    );
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

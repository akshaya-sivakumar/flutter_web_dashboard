import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/model/watchlist/watchlist_model.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../auto_route/router.gr.dart';
import '../constants/app_constants.dart';
import '../constants/app_routes.dart';
import '../constants/appwidget_size.dart';
import '../main.dart';
import '../ui/widgets/text_widget.dart';

class AppUtils {
  final iv = encrypt.IV.fromBase64("Some_Key");
  static bool isDarktheme = false;

  bool isLoginned() {
    return (window.sessionStorage["login"] != null &&
            window.sessionStorage["login"] != "")
        ? true
        : false;
  }

  storeLogin(String sessionid) {
    window.sessionStorage[AppConstants.loginKey] = sessionid;
  }

  clearsession() {
    window.sessionStorage[AppConstants.loginKey] = "";
  }

  List getUserlist() {
    final encrypt.Encrypter encrypter = encrypt.Encrypter(
        encrypt.AES(encrypt.Key.fromUtf8(AppConstants.encryptKey)));
    final encryptedDataString =
        (window.localStorage[AppConstants.usersList]) ?? "";
    encrypt.Encrypted encryptedData =
        encrypt.Encrypted.fromBase64(encryptedDataString);
    if (encryptedData.bytes.isEmpty) return [];
    final decryptedData = encrypter.decrypt(encryptedData, iv: iv);
    return json.decode(decryptedData);
  }

  storeUserlist(dynamic userData, {bool save = true}) {
    final encrypt.Encrypter encrypter = encrypt.Encrypter(
        encrypt.AES(encrypt.Key.fromUtf8(AppConstants.encryptKey)));

    List data = getUserlist();

    if (data.isEmpty) {
      encrypt.Encrypted encryptedData =
          encrypter.encrypt(json.encode([userData]), iv: iv);
      window.localStorage[AppConstants.usersList] = encryptedData.base64;
    } else {
      if (!save) {
        data.removeWhere((element) =>
            element[AppConstants.usernameKey] ==
            userData[AppConstants.usernameKey]);
      }
      data.add(userData);
      encrypt.Encrypted encryptedData =
          encrypter.encrypt(json.encode(data), iv: iv);
      window.localStorage[AppConstants.usersList] = encryptedData.base64;
    }
  }

  bool isuserexist(data) {
    List userList = getUserlist();
    return userList
        .where((element) => (element[AppConstants.usernameKey] ==
                data[AppConstants.usernameKey] &&
            element[AppConstants.passwordKey] ==
                data[AppConstants.passwordKey]))
        .toList()
        .isNotEmpty;
  }

  String createDotString(int length) {
    return AppConstants.passwordHidden * length;
  }

  WatchlistModel? getfromCrypto() {
    final encrypt.Encrypter encrypter = encrypt.Encrypter(
        encrypt.AES(encrypt.Key.fromUtf8(AppConstants.encryptKey)));
    final encryptedDataString = window.localStorage[AppConstants.watchlistKey];
    encrypt.Encrypted encryptedData =
        encrypt.Encrypted.fromBase64(encryptedDataString ?? "");
    if (encryptedData.bytes.isEmpty) return null;
    final decryptedData = encrypter.decrypt(encryptedData, iv: iv);

    return WatchlistModel.fromJson(
        json.decode(decryptedData == "" ? "{}" : decryptedData));
  }

  setinCrypto(WatchlistModel data) {
    final encrypt.Encrypter encrypter = encrypt.Encrypter(
        encrypt.AES(encrypt.Key.fromUtf8(AppConstants.encryptKey)));
    encrypt.Encrypted encryptedData =
        encrypter.encrypt(json.encode(data.toJson()), iv: iv);
    window.localStorage[AppConstants.watchlistKey] = encryptedData.base64;
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
                          appRoute.removeUntil((route) => false);
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

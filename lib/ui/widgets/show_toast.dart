import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Apptoast {
  Future<bool?> toastWidget(String message) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 5,
        webPosition: AppConstants.webPosition,
        webShowClose: true,
        toastLength: Toast.LENGTH_LONG,
        webBgColor: AppConstants.webBgColor,
        fontSize: 20.0);
  }
}

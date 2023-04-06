import 'package:auto_route/auto_route.dart';
import 'package:flutter_dashboard_web/auto_route/router.gr.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
        path: "/registration",
        page: Registration.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        guards: [LoginGuard()],
        reverseDurationInMilliseconds: 0),
    CustomRoute(
        path: "/dashboard",
        page: Dashboard.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        guards: [AuthGuard()],
        reverseDurationInMilliseconds: 0),
    AutoRoute(
      path: "*",
      page: Notfound.page,
    ),
  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    if (AppUtils().isLoginned()) {
      resolver.next(true);
    } else {
      router.push(const Registration());
      Fluttertoast.showToast(
          msg: AppConstants.sessionExpired,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 5,
          webPosition: AppConstants.webPosition,
          webShowClose: true,
          toastLength: Toast.LENGTH_LONG,
          webBgColor: AppConstants.webBgColor,
          fontSize: AppWidgetSize.dimen_20);
    }
  }
}

class LoginGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    if (AppUtils().isLoginned()) {
      appRoute.pushNamed("/dashboard?index=0");
    } else {
      resolver.next(true);
    }
  }
}

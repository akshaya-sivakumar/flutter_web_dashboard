import 'package:auto_route/auto_route.dart';
import 'package:flutter_dashboard_web/auto_route/router.gr.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/constants/app_routes.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

@AutoRouterConfig(
  deferredLoading: true,
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  AppRouter();
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
        path: AppRoutes.registrationRoute,
        page: Registration.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        guards: [LoginGuard()],
        keepHistory: false,
        reverseDurationInMilliseconds: 0),
    RedirectRoute(
        path: AppRoutes.emptyRoute, redirectTo: AppRoutes.registrationRoute),
    CustomRoute(
        path: AppRoutes.dashboardRoute,
        page: Dashboard.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        // guards: [AuthGuard()],
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
    if (AppUtils().isLoginned() &&
        router.current.path == AppRoutes.dashboardRoute) {
      AppUtils().logoutDialog(appRoute.navigatorKey.currentContext,
          fromNavigation: true);
    } else if (AppUtils().isLoginned()) {
      appRoute.pushNamed(AppRoutes.watchlistRoute);
    } else {
      resolver.next(true);
    }
  }
}

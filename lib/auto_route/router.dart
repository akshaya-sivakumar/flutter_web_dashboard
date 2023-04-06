import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/auto_route/router.gr.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../main.dart';
import '../ui/widgets/text_widget.dart';

@AutoRouterConfig(
  deferredLoading: true,
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  AppRouter();
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
        path: "/registration",
        page: Registration.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        guards: [LoginGuard()],
        keepHistory: false,
        reverseDurationInMilliseconds: 0),
    RedirectRoute(path: "/", redirectTo: "/registration"),
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
    print("checking");
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
    if (AppUtils().isLoginned() && router.current.path == "/dashboard") {
      logoutDialog(appRoute.navigatorKey.currentContext);
    } else if (AppUtils().isLoginned()) {
      // appRoute.replaceNamed("/dashboard?index=0");
      appRoute.pushNamed("/dashboard?index=0");
    } else {
      resolver.next(true);
    }
  }

  void logoutDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return PointerInterceptor(
          intercepting: true,
          child: AlertDialog(
              title: TextWidget(
                "Confirm Logout !!!",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    "Are you sure you want to logout?",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          AppUtils().clearsession();
                          appRoute.removeUntil((route) => true);
                          appRoute.replaceAll([const Registration()]);
                        },
                        child: TextWidget(
                          "LOGOUT",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).canvasColor,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          appRoute.pop();

                          appRoute.pushNamed("/dashboard?index=0");
                        },
                        child: TextWidget(
                          "CANCEL",
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

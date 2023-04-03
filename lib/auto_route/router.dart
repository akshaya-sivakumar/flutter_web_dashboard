import 'package:auto_route/auto_route.dart';
import 'package:flutter_dashboard_web/auto_route/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
        page: Registration.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 0),
    CustomRoute(
        path: "/dashboard",
        page: Dashboard.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 0),

    /* CustomRoute(
        page: Watchlist.page,
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 0),

        CustomRoute(
      path: '/navigatorrail',
      page: Dashboard,
      name: "DashboardRoute",
      guards: [AuthGuard],
      children: [],
      transitionsBuilder: TransitionsBuilders.slideRight,
    ), */
    AutoRoute(
      path: "*",
      page: Notfound.page,
    ),
  ];
}

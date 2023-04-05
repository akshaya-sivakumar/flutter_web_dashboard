import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/theme/dartTheme.dart';
import 'package:flutter_dashboard_web/theme/lightTheme.dart';

import 'auto_route/router.dart';
import 'bloc/theme/theme_bloc.dart';

final appRoute = AppRouter();
void main() {
  runApp(BlocProvider(
    create: (context) => ThemeBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BlocProvider.of<ThemeBloc>(context).add(FetchthemeEvent());

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Dashboard',
          theme: state.theme == true ? darkTheme() : lightTheme(),
          routerDelegate: appRoute.delegate(
              navigatorObservers: () => [AutoRouteObserver()],

              /*  initialDeepLink: AppUtils().isLoginned()
                ? "/dashboard?index=0"
                : "/registration", */
              /* initialRoutes: [
            AppUtils().isLoginned() ? const Dashboard() : const Registration()
          ] */
              initialDeepLink: "/registration"),
          routeInformationParser: appRoute.defaultRouteParser(),
        );
      },
    );
  }
}

/* class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print(
        'New route pushed: ${route.settings.name} - ${previousRoute?.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    print('Tab route visited: ${route.name} - ${previousRoute?.name} ');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    print('Tab route re-visited: ${route.name} - ${previousRoute.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    'New route pushed: ${route.settings.name} - ${previousRoute?.settings.name}';
  }
} */

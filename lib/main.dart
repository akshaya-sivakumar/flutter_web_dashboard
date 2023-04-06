import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/theme/dart_theme.dart';
import 'package:flutter_dashboard_web/theme/light_theme.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';

import 'auto_route/router.dart';
import 'auto_route/router.gr.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        AppUtils.isDarktheme = state.theme;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppConstants.dashboard,
          theme: state.theme == true ? darkTheme() : lightTheme(),
          routerConfig: appRoute.config(initialRoutes: [const Registration()]),
        );
      },
    );
  }
}

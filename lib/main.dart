import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
final FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      authDomain: "flutterdashboard-cab5f.firebaseapp.com",
      apiKey: "AIzaSyAYkM1F2iXPAoqtbxbJUDVsAiGgymuR8fU",
      appId: "1:224539913113:web:7267c3ff4fdd2b0359c108",
      messagingSenderId: "224539913113",
      projectId: "flutterdashboard-cab5f",
    ),
  );
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

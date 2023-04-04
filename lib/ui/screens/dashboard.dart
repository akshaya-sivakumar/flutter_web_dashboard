import 'dart:html' as html;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/bloc/watchlist/watchlist_bloc.dart';
import 'package:flutter_dashboard_web/ui/screens/not_found.dart';
import 'package:flutter_dashboard_web/ui/screens/orders.dart';
import 'package:flutter_dashboard_web/ui/screens/portfolio.dart';
import 'package:flutter_dashboard_web/ui/screens/watchlist.dart';

import '../../main.dart';

@RoutePage(name: "dashboard")
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    html.window.onPopState.listen((_) {
      final navigator = Navigator.of(context, rootNavigator: true);
      print("back");
      /*   if (navigator.canPop()) {
        navigator.pop();
      } */
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.routeData.queryParams.get("index") == null) {
      appRoute.pushNamed("/dashboard?index=0");
    }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: (context.routeData.queryParams.get("index") == "0")
          ? BlocProvider(
              create: (context) => WatchlistBloc(),
              child: const WatchlistScreen(),
            )
          : context.routeData.queryParams.get("index") == "1"
              ? const OrderScreen()
              : context.routeData.queryParams.get("index") == "2"
                  ? const PortfolioScreen()
                  : const NotFoundScreen(),
    );
  }
}

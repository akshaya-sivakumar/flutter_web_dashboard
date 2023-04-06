import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/bloc/watchlist/watchlist_bloc.dart';
import 'package:flutter_dashboard_web/ui/screens/not_found.dart';
import 'package:flutter_dashboard_web/ui/screens/orders.dart';
import 'package:flutter_dashboard_web/ui/screens/portfolio.dart';
import 'package:flutter_dashboard_web/ui/screens/watchlist.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../auto_route/router.gr.dart';
import '../../main.dart';
import '../../utils/app_utils.dart';
import '../widgets/text_widget.dart';

@RoutePage(name: "dashboard")
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.routeData.queryParams.get("index") == null) {
      appRoute.pushNamed("/dashboard?index=0");
    }

    return (context.routeData.queryParams.get("index") == "0")
        ? BlocProvider(
            create: (context) => WatchlistBloc(),
            child: const WatchlistScreen(),
          )
        : context.routeData.queryParams.get("index") == "1"
            ? const OrderScreen()
            : context.routeData.queryParams.get("index") == "2"
                ? const PortfolioScreen()
                : const NotFoundScreen();
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
                          appRoute.push(const Registration());
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

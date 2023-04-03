import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/auto_route/router.gr.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../../constants/app_images.dart';
import '../../main.dart';

class NavigationIcon {
  final Widget icon;
  final Widget selectedLighticon;
  final Widget selectedDarkicon;
  final String label;

  NavigationIcon(
      this.icon, this.selectedLighticon, this.selectedDarkicon, this.label);
}

class NavigatorRailwidget extends StatefulWidget {
  final Widget child;
  final int selectedindex;
  const NavigatorRailwidget(
      {super.key, required this.child, required this.selectedindex});

  @override
  State<NavigatorRailwidget> createState() => _NavigatorRailwidgetState();
}

class _NavigatorRailwidgetState extends State<NavigatorRailwidget> {
  ValueNotifier<bool> expanded = ValueNotifier<bool>(false);
  NavigationRailLabelType labelType = NavigationRailLabelType.none;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = -1.0;

  bool theme = false;
  @override
  void initState() {
    getTheme();

    super.initState();
  }

  getTheme() {
    BlocProvider.of<ThemeBloc>(context)
      ..add(FetchthemeEvent())
      ..stream.listen((event) {
        theme = event.theme;
      });
  }

  @override
  void didChangeDependencies() {
    navigationIcons = [
      NavigationIcon(
          AppImages.watchlist(
            context,
            color: Theme.of(context).accentIconTheme.color!,
          ),
          AppImages.watchlistSelected(),
          AppImages.watchlistSelectedDark(),
          "Watchlist"),
      NavigationIcon(
          AppImages.orderbook(
            context,
            color: Theme.of(context).accentIconTheme.color!,
          ),
          AppImages.ordersSelected(),
          AppImages.ordersSelectedDark(),
          "Orders"),
      NavigationIcon(
          AppImages.portfolio(
            context,
            color: Theme.of(context).accentIconTheme.color!,
          ),
          AppImages.portfolioSelected(),
          AppImages.portfolioSelectedDark(),
          "Portfolio"),
      NavigationIcon(
          Icon(Icons.logout,
              size: 30, color: Theme.of(context).scaffoldBackgroundColor),
          Icon(
            Icons.logout,
            size: 30,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Icon(
            Icons.logout,
            size: 30,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          "Logout"),
    ];
    super.didChangeDependencies();
  }

  late List<NavigationIcon> navigationIcons;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return constraints.maxWidth > 730
          ? Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1),
                    child: Divider(
                      height: 1,
                      color: Theme.of(context).dividerColor,
                    )),
                toolbarHeight: 40,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ThemechangeEvent(!theme));
                      },
                      icon: window.localStorage["flutter.isDark"] == "true"
                          ? AppImages.darkThemeIcon(context,
                              color: Colors.white, width: 50, height: 50)
                          : AppImages.lightThemeIcon(context,
                              color: Colors.black, width: 50, height: 50))
                ],
              ),
              body: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    MouseRegion(
                      onEnter: (_) => expanded.value = true,
                      onExit: (_) => expanded.value = false,
                      child: ValueListenableBuilder<bool>(
                          valueListenable: expanded,
                          builder: (context, snapshot, _) {
                            return NavigationRail(
                                backgroundColor: Theme.of(context).primaryColor,
                                selectedIndex: widget.selectedindex,
                                unselectedLabelTextStyle: GoogleFonts.salsa(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                selectedLabelTextStyle: GoogleFonts.salsa(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                groupAlignment: groupAligment,
                                extended: expanded.value,
                                minWidth: 70,
                                useIndicator: true,
                                indicatorColor:
                                    Theme.of(context).primaryColorLight,
                                onDestinationSelected: (int index) {
                                  if (index == 3) {
                                    AppUtils().clearsession();
                                    appRoute.push(const Registration());
                                  } else {
                                    appRoute
                                        .pushNamed('/dashboard?index=$index');
                                  }
                                },
                                labelType: labelType,
                                destinations: navigationIcons
                                    .map((e) => NavigationRailDestination(
                                          icon: SizedBox(
                                            height: 35,
                                            child: e.icon,
                                          ),
                                          selectedIcon: SizedBox(
                                            height: 35,
                                            child: window.sessionStorage[
                                                        "isDark"] !=
                                                    "true"
                                                ? e.selectedLighticon
                                                : e.selectedDarkicon,
                                          ),
                                          label: Text(
                                            e.label,
                                          ),
                                        ))
                                    .toList());
                          }),
                    ),

                    // This is the main content.
                    widget.child,
                  ],
                ),
              ),
            )
          : Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                unselectedIconTheme: const IconThemeData(color: Colors.white),
                selectedIconTheme: const IconThemeData(color: Colors.red),
                unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
                selectedItemColor: Colors.red,
                showUnselectedLabels: false,
                selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.red),
                backgroundColor: Colors.green[900],
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list,
                      size: 40,
                    ),
                    label: "Watchlist",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bookmark_border,
                      size: 40,
                    ),
                    label: 'About',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: widget.selectedindex,
                onTap: (index) {},
              ),
              body: widget.child);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../auto_route/router.gr.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../constants/app_images.dart';
import '../../constants/appwidget_size.dart';
import '../../main.dart';
import '../../utils/app_utils.dart';

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
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          AppImages.watchlistSelected(),
          AppImages.watchlistSelectedDark(),
          AppConstants.watchlist),
      NavigationIcon(
          AppImages.orderbook(
            context,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          AppImages.ordersSelected(),
          AppImages.ordersSelectedDark(),
          AppConstants.orders),
      NavigationIcon(
          AppImages.portfolio(
            context,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          AppImages.portfolioSelected(),
          AppImages.portfolioSelectedDark(),
          AppConstants.portfolio),
      NavigationIcon(
          Icon(Icons.logout,
              size: AppWidgetSize.dimen_30,
              color: Theme.of(context).scaffoldBackgroundColor),
          Icon(
            Icons.logout,
            size: AppWidgetSize.dimen_30,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Icon(
            Icons.logout,
            size: AppWidgetSize.dimen_30,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          AppConstants.logout),
    ];
    super.didChangeDependencies();
  }

  late List<NavigationIcon> navigationIcons;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        logoutDialog();
        return false;
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > 730
            ? Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(1),
                      child: Divider(
                        height: AppWidgetSize.dimen_1,
                        color: Theme.of(context).dividerColor,
                      )),
                  toolbarHeight: AppWidgetSize.dimen_40,
                  automaticallyImplyLeading: false,
                  actions: [
                    BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(ThemechangeEvent(!theme));
                            },
                            icon: state.theme
                                ? AppImages.darkThemeIcon(context,
                                    color: Colors.white,
                                    width: AppWidgetSize.dimen_40,
                                    height: AppWidgetSize.dimen_40)
                                : AppImages.lightThemeIcon(context,
                                    color: Colors.black,
                                    width: AppWidgetSize.dimen_40,
                                    height: AppWidgetSize.dimen_40));
                      },
                    )
                  ],
                ),
                body: Center(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      railWidget(),

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
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppWidgetSize.dimen_15,
                      color: Colors.white),
                  selectedItemColor: Colors.red,
                  showUnselectedLabels: false,
                  selectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppWidgetSize.dimen_15,
                      color: Colors.red),
                  backgroundColor: Colors.green[900],
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list,
                        size: AppWidgetSize.dimen_40,
                      ),
                      label: "Watchlist",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.bookmark_border,
                        size: AppWidgetSize.dimen_40,
                      ),
                      label: 'About',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_circle,
                        size: AppWidgetSize.dimen_40,
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: widget.selectedindex,
                  onTap: (index) {},
                ),
                body: widget.child);
      }),
    );
  }

  MouseRegion railWidget() {
    return MouseRegion(
      onEnter: (_) => expanded.value = true,
      onExit: (_) => expanded.value = false,
      child: ValueListenableBuilder<bool>(
          valueListenable: expanded,
          builder: (context, snapshot, _) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return NavigationRail(
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedIndex: widget.selectedindex,
                    unselectedLabelTextStyle: GoogleFonts.salsa(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    selectedLabelTextStyle: GoogleFonts.salsa(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    groupAlignment: groupAligment,
                    extended: expanded.value,
                    minWidth: AppWidgetSize.dimen_70,
                    useIndicator: true,
                    indicatorColor: Theme.of(context).primaryColorLight,
                    onDestinationSelected: (int index) {
                      if (index == 3) {
                        logoutDialog();
                      } else {
                        appRoute.pushNamed('/dashboard?index=$index');
                      }
                    },
                    labelType: labelType,
                    destinations: navigationIcons
                        .map((e) => NavigationRailDestination(
                              icon: SizedBox(
                                height: AppWidgetSize.dimen_35,
                                child: e.icon,
                              ),
                              selectedIcon: SizedBox(
                                height: AppWidgetSize.dimen_35,
                                child: state.theme
                                    ? e.selectedDarkicon
                                    : e.selectedLighticon,
                              ),
                              label: Text(
                                e.label,
                              ),
                            ))
                        .toList());
              },
            );
          }),
    );
  }

  void logoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return PointerInterceptor(
          intercepting: true,
          child: AlertDialog(
              title: TextWidget(
                AppConstants.confirmLogout,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: AppWidgetSize.dimen_16,
                    fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    AppConstants.logoutStatement,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: AppWidgetSize.dimen_14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: AppWidgetSize.dimen_20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: AppWidgetSize.dimen_10,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          AppUtils().clearsession();
                          appRoute.push(const Registration());
                        },
                        child: TextWidget(
                          AppConstants.logout,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(
                        width: AppWidgetSize.dimen_15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).canvasColor,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: AppWidgetSize.dimen_10,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          appRoute.pop();
                        },
                        child: TextWidget(
                          AppConstants.cancel,
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

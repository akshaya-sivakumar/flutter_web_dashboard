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
          print("params");
          return false;
        },
        child: Scaffold(
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
              IconButton(
                  onPressed: () {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemechangeEvent(!theme));
                  },
                  icon: AppUtils.isDarktheme
                      ? AppImages.darkThemeIcon(context,
                          color: Colors.white,
                          width: AppWidgetSize.dimen_50,
                          height: AppWidgetSize.dimen_50)
                      : AppImages.lightThemeIcon(context,
                          color: Colors.black,
                          width: AppWidgetSize.dimen_50,
                          height: AppWidgetSize.dimen_50))
            ],
          ),
          body: Stack(
            children: <Widget>[
              // This is the main content.
              Padding(
                  padding: const EdgeInsets.only(
                    left: 80,
                  ),
                  child: widget.child),
              railWidget()
            ],
          ),
        ));
  }

  MouseRegion railWidget() {
    return MouseRegion(
        onEnter: (_) => expanded.value = true,
        onExit: (_) => expanded.value = false,
        child: ValueListenableBuilder<bool>(
          valueListenable: expanded,
          builder: (context, snapshot, _) {
            return SizedBox(
              width: snapshot ? 170 : 80,
              //constraints: const BoxConstraints(maxWidth: 170),
              child: NavigationRail(
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedIndex: widget.selectedindex,
                  unselectedLabelTextStyle: GoogleFonts.salsa(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  selectedLabelTextStyle: GoogleFonts.salsa(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  groupAlignment: groupAligment,
                  extended: expanded.value,
                  minWidth: AppWidgetSize.dimen_80,
                  /* useIndicator: true,
                  
                  indicatorColor: Theme.of(context).primaryColorLight, */
                  onDestinationSelected: (int index) {
                    if (index == 3) {
                      logoutDialog();
                    } else {
                      appRoute.pushNamed('/dashboard?index=$index');
                    }
                  },
                  labelType: snapshot
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.selected,
                  destinations: navigationIcons
                      .map((e) => NavigationRailDestination(
                            icon: SizedBox(
                              height: AppWidgetSize.dimen_35,
                              child: e.icon,
                            ),
                            selectedIcon: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(30)),
                              height: AppWidgetSize.dimen_40,
                              child: AppUtils.isDarktheme
                                  ? e.selectedDarkicon
                                  : e.selectedLighticon,
                            ),
                            label: snapshot
                                ? Text(
                                    e.label,
                                  )
                                : const SizedBox.shrink(),
                          ))
                      .toList()),
            );
          },
        ));
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
                          appRoute.replaceAll([const Registration()]);
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

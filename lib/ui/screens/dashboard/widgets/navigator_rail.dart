import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../bloc/theme/theme_bloc.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/appwidget_size.dart';
import '../../../../main.dart';
import '../../../../utils/app_utils.dart';

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
    super.initState();
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
    return Scaffold(
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
                    .add(ThemechangeEvent(!AppUtils.isDarktheme));
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
    );
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
                      AppUtils().logoutDialog(context);
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
}

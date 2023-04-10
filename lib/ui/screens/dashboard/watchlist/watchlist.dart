import 'dart:math';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/constants/app_images.dart';
import 'package:flutter_dashboard_web/main.dart';
import 'package:flutter_dashboard_web/model/watchlist/watchlist_model.dart';
import 'package:flutter_dashboard_web/ui/screens/dashboard/watchlist/order_pad.dart';
import 'package:flutter_dashboard_web/ui/widgets/search_widget.dart';
import 'package:flutter_dashboard_web/ui/widgets/swap_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webviewx/webviewx.dart';

import '../../../../bloc/watchlist/watchlist_bloc.dart';
import '../../../../constants/appwidget_size.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/horizontal_list_view.dart';
import '../../../widgets/market_depth_widget.dart';
import '../../../widgets/text_widget.dart';
import '../widgets/navigator_rail.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  WebViewXController? controller;
  late WatchlistBloc watchlistBloc;
  Data searchWatchlist = Data(symbols: []);
  Data watchlist = Data(symbols: []);
  Random random = Random();
  ValueNotifier<String> selectedmyList =
      ValueNotifier<String>(AppConstants.myListData[0]);
  ValueNotifier<int> selectedindex = ValueNotifier<int>(0);
  ValueNotifier<bool> watchlistSelected = ValueNotifier<bool>(false);
  ValueNotifier<bool> buySelected = ValueNotifier<bool>(true);
  ValueNotifier<bool> isHover = ValueNotifier<bool>(false);
  ValueNotifier<Symbols?> selectedsymbol = ValueNotifier<Symbols?>(null);
  bool atoz = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    watchlistBloc = BlocProvider.of<WatchlistBloc>(context);

    watchlistBloc.add(FetchWatchlist(selectedmyList.value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorRailwidget(
      selectedindex: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
              if (state is WatchlistDone) {
                selectedsymbol.value ??=
                    state.watchlist.response.data.symbols.first;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (!watchlistSelected.value) {
                    watchlistSelected.value = true;
                  }
                });

                watchlist = state.watchlist.response.data;

                return doneStateWidget(context);
              }

              if (state is WatchlistError) return const ErrorsWidget();
              return loadData(context);
            },
          ),
          Container(
            color: Theme.of(context).dividerColor.withOpacity(0.3),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ValueListenableBuilder<bool>(
                          valueListenable: watchlistSelected,
                          builder: (context, selected, _) {
                            return selected
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppWidgetSize.dimen_10,
                                        vertical: AppWidgetSize.dimen_10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).focusColor,
                                          ),
                                          onPressed: () {
                                            buySelected.value = true;
                                            showOrderpadpopup(
                                              context,
                                            );
                                          },
                                          child: TextWidget(
                                            AppConstants.buy,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor),
                                          ),
                                        ),
                                        SizedBox(
                                          width: AppWidgetSize.dimen_10,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .snackBarTheme
                                                .closeIconColor,
                                          ),
                                          onPressed: () {
                                            buySelected.value = false;
                                            showOrderpadpopup(
                                              context,
                                            );
                                          },
                                          child: TextWidget(
                                            AppConstants.sell,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container();
                          }),
                      FutureBuilder(
                        future:
                            Future.delayed(const Duration(milliseconds: 10)),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.done
                              ? WebViewX(
                                  javascriptMode: JavascriptMode.unrestricted,
                                  initialContent: AppConstants().weburl,
                                  onWebViewCreated: (controllers) {
                                    controller = controllers;
                                  },
                                  width:
                                      AppWidgetSize.fullWidth(context) * 0.6 +
                                          AppWidgetSize.dimen_70,
                                  height:
                                      AppWidgetSize.fullHeight(context) * 0.55 -
                                          AppWidgetSize.dimen_20,
                                )
                              : SizedBox(
                                  width:
                                      AppWidgetSize.fullWidth(context) * 0.6 +
                                          AppWidgetSize.dimen_70,
                                  height:
                                      AppWidgetSize.fullHeight(context) * 0.55 -
                                          AppWidgetSize.dimen_20,
                                  child: const Center(
                                      child: CircularProgressIndicator()));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    margin: EdgeInsets.only(
                        top: AppWidgetSize.dimen_10,
                        left: AppWidgetSize.dimen_10),
                    padding: EdgeInsets.only(left: AppWidgetSize.dimen_20),
                    width: AppWidgetSize.fullWidth(context) * 0.6 +
                        AppWidgetSize.dimen_70,
                    height: AppWidgetSize.fullHeight(context) * 0.35 -
                        AppWidgetSize.dimen_20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<int>(
                          valueListenable: selectedindex,
                          builder: (context, stateValue, _) {
                            return horizontalListView(
                              fontSize: AppWidgetSize.dimen_14,
                              values: AppConstants.quoteTablist,
                              selectedIndex: stateValue,
                              isEnabled: true,
                              isRectShape: false,
                              callback: (value, index) {
                                selectedindex.value = index;
                              },
                              highlighterColor: Theme.of(context).primaryColor,
                              context: context,
                            );
                          },
                        ),
                        ValueListenableBuilder<int>(
                            valueListenable: selectedindex,
                            builder: (context, index, _) {
                              return index == 0
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const MarketDepthwidget(),
                                        SizedBox(
                                          width: AppWidgetSize.dimen_10,
                                          height: AppWidgetSize.fullHeight(
                                                      context) *
                                                  0.3 -
                                              AppWidgetSize.dimen_30,
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            lineLength: double.infinity,
                                            lineThickness:
                                                AppWidgetSize.dimen_1,
                                            dashLength: AppWidgetSize.dimen_4,
                                            dashColor:
                                                Theme.of(context).dividerColor,
                                            dashGapLength:
                                                AppWidgetSize.dimen_4,
                                            dashGapColor: Colors.transparent,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              AppWidgetSize.fullWidth(context) *
                                                  0.28,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        AppWidgetSize.dimen_10,
                                                    horizontal:
                                                        AppWidgetSize.dimen_10),
                                                child: TextWidget(
                                                  AppConstants.details,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                          fontSize:
                                                              AppWidgetSize
                                                                  .dimen_16),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        AppWidgetSize.dimen_10,
                                                    horizontal:
                                                        AppWidgetSize.dimen_10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    detailColumn(
                                                        AppConstants.prevClose,
                                                        AppConstants
                                                            .prevCloseValue),
                                                    detailColumn(
                                                        AppConstants.open,
                                                        AppConstants.openValue),
                                                    detailColumn(
                                                        AppConstants.high,
                                                        AppConstants.highValue),
                                                    detailColumn(
                                                        AppConstants.low,
                                                        AppConstants.lowValue),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        AppWidgetSize.dimen_10),
                                                child: DottedLine(
                                                  direction: Axis.horizontal,
                                                  lineLength: double.infinity,
                                                  lineThickness:
                                                      AppWidgetSize.dimen_0_5,
                                                  dashLength:
                                                      AppWidgetSize.dimen_4,
                                                  dashColor: Theme.of(context)
                                                      .dividerColor,
                                                  dashGapLength:
                                                      AppWidgetSize.dimen_3,
                                                  dashGapColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                              _buildSeekBarWidget()
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : index == 1
                                      ? TextWidget(
                                          AppConstants.quoteTablist[index])
                                      : index == 3
                                          ? TextWidget(
                                              AppConstants.quoteTablist[index])
                                          : index == 4
                                              ? TextWidget(AppConstants
                                                  .quoteTablist[index])
                                              : TextWidget(AppConstants
                                                  .quoteTablist[index]);
                            })
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildIndicatorLeadingTrailingWidget(
    bool isLeading,
    String headline1,
    String headline2,
  ) {
    return Column(
      crossAxisAlignment:
          isLeading ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_10),
          child: TextWidget(
            headline1,
            style: Theme.of(appRoute.navigatorKey.currentContext!)
                .primaryTextTheme
                .bodyLarge!
                .copyWith(
                  color: Theme.of(appRoute.navigatorKey.currentContext!)
                      .primaryTextTheme
                      .bodySmall!
                      .color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        _buildFiftyWeekLabel(
          headline2,
          isLeading,
        ),
      ],
    );
  }

  static Widget _buildFiftyWeekLabel(
    String value,
    bool isLeft,
  ) {
    return Container(
      width: AppWidgetSize.dimen_80,
      constraints: BoxConstraints(maxHeight: AppWidgetSize.dimen_30),
      decoration: BoxDecoration(
        borderRadius: isLeft
            ? BorderRadius.only(
                topLeft: Radius.circular(AppWidgetSize.dimen_20),
                bottomLeft: Radius.circular(AppWidgetSize.dimen_20),
              )
            : BorderRadius.only(
                topRight: Radius.circular(AppWidgetSize.dimen_20),
                bottomRight: Radius.circular(AppWidgetSize.dimen_20),
              ),
        color: Theme.of(appRoute.navigatorKey.currentContext!)
            .snackBarTheme
            .backgroundColor!
            .withOpacity(0.5),
      ),
      alignment: Alignment.center,
      child: TextWidget(
        value,
        style: Theme.of(appRoute.navigatorKey.currentContext!)
            .primaryTextTheme
            .bodySmall!
            .copyWith(
              fontWeight: FontWeight.w600,
            )
            .copyWith(
              fontSize: AppWidgetSize.dimen_10,
            ),
      ),
    );
  }

  static Widget _buildSeekBarWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: AppWidgetSize.dimen_25, left: AppWidgetSize.dimen_20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                "52Wk High/Low",
                style: Theme.of(appRoute.navigatorKey.currentContext!)
                    .textTheme
                    .labelSmall
                    ?.copyWith(
                        fontSize: AppWidgetSize.dimen_12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(appRoute.navigatorKey.currentContext!)
                            .canvasColor,
                        fontFamily: AppConstants.fontName),
              ),
              TextWidget(
                "Upper/Lower Circuit",
                style: Theme.of(appRoute.navigatorKey.currentContext!)
                    .textTheme
                    .labelSmall
                    ?.copyWith(
                        fontSize: AppWidgetSize.dimen_12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(appRoute.navigatorKey.currentContext!)
                            .canvasColor,
                        fontFamily: AppConstants.fontName),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: AppWidgetSize.dimen_15, left: AppWidgetSize.dimen_20),
          height: AppWidgetSize.dimen_8,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(AppWidgetSize.dimen_20)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: const <double>[
                0.3,
                0.7,
              ],
              colors: <Color>[
                Theme.of(appRoute.navigatorKey.currentContext!).focusColor,
                Theme.of(appRoute.navigatorKey.currentContext!)
                    .snackBarTheme
                    .closeIconColor!,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container doneStateWidget(BuildContext context) {
    return Container(
      width: AppWidgetSize.fullWidth(context) * 0.3 - AppWidgetSize.dimen_80,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(AppConstants.nifty50,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppWidgetSize.dimen_14,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle
                                ?.color)),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_5),
                      child: Row(
                        children: [
                          TextWidget(AppConstants.niftyvalue,
                              style: Theme.of(context).textTheme.titleLarge),
                          TextWidget(
                            AppConstants.niftyPer,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: AppWidgetSize.dimen_13,
                                    color: Theme.of(context)
                                        .snackBarTheme
                                        .closeIconColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(AppConstants.sensex,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: AppWidgetSize.dimen_14,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle
                                ?.color)),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_5),
                      child: Row(
                        children: [
                          TextWidget(AppConstants.sensexvalue,
                              style: Theme.of(context).textTheme.titleLarge),
                          TextWidget(
                            AppConstants.sensexPer,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize: AppWidgetSize.dimen_13,
                                    color: Theme.of(context)
                                        .snackBarTheme
                                        .closeIconColor),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_5),
            child: DottedLine(
              direction: Axis.horizontal,
              lineLength: double.infinity,
              lineThickness: AppWidgetSize.dimen_0_5,
              dashLength: AppWidgetSize.dimen_4,
              dashColor: Theme.of(context).dividerColor,
              dashGapLength: AppWidgetSize.dimen_3,
              dashGapColor: Colors.transparent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<String>(
                  valueListenable: selectedmyList,
                  builder: (context, snapshot, _) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor:
                              Theme.of(context).scaffoldBackgroundColor),
                      child: CustomDropdownButton(
                        iconSize: AppWidgetSize.dimen_15,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        value: snapshot,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppWidgetSize.dimen_13),
                        underline: const Divider(
                          color: Colors.transparent,
                        ),
                        items: AppConstants.myListData.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedmyList.value = value;
                          watchlistSelected.value = false;
                          selectedsymbol.value = null;
                          searchController.clear();
                          watchlistBloc.add(SortWatchlist(atoz, value));
                        },
                      ),
                    );
                  }),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                icon: Icon(
                  Icons.sort,
                  size: AppWidgetSize.dimen_20,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
                onSelected: (item) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      atoz = true;
                      watchlistBloc
                          .add(SortWatchlist(atoz, AppConstants.myListData[0]));
                    },
                    value: atoz,
                    child: Row(
                      children: [
                        TextWidget(
                          AppConstants.atoz,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: AppWidgetSize.dimen_15,
                                  ),
                        ),
                        if (atoz)
                          Padding(
                            padding:
                                EdgeInsets.only(left: AppWidgetSize.dimen_15),
                            child: Icon(
                              Icons.check_rounded,
                              size: AppWidgetSize.dimen_15,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      atoz = false;
                      watchlistBloc
                          .add(SortWatchlist(atoz, AppConstants.myListData[0]));
                    },
                    value: !atoz,
                    child: Row(
                      children: [
                        TextWidget(
                          AppConstants.ztoa,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: AppWidgetSize.dimen_15,
                                  ),
                        ),
                        if (!atoz)
                          Padding(
                            padding:
                                EdgeInsets.only(left: AppWidgetSize.dimen_15),
                            child: Icon(Icons.check_rounded,
                                size: AppWidgetSize.dimen_17,
                                color: Theme.of(context).primaryColor),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            child: searchBox(searchController, "", "", () {
              watchlistBloc.add(SortWatchlist(atoz, selectedmyList.value,
                  searchName: searchController.text));
            }),
          ),
          watchlist.symbols.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: AppWidgetSize.dimen_100),
                  child: Column(
                    children: [
                      AppImages.nosearchlottie(),
                      TextWidget(
                        (watchlist.symbols.isEmpty &&
                                searchController.text.isEmpty)
                            ? AppConstants.nodata
                            : AppConstants.nosearchdata,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: GoogleFonts.alumniSans().fontFamily,
                            fontSize: AppWidgetSize.dimen_20),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: AppWidgetSize.dimen_10),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: watchlist.symbols.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            selectedsymbol.value = watchlist.symbols[index];
                            controller?.reload();
                          },
                          child: bodyData(context, watchlist, index));
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void showOrderpadpopup(BuildContext context) {
    showAlignedDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(top: AppWidgetSize.dimen_41),
            child: PointerInterceptor(
              intercepting: true,
              child: ValueListenableBuilder(
                  valueListenable: buySelected,
                  builder: (context, snapshot, _) {
                    return OrderPadWindow(
                      buySelected: buySelected.value,
                      symbol: selectedsymbol.value!,
                      onChanged: (value) {
                        buySelected.value = !value;
                      },
                    );
                  }),
            ),
          );
        },
        followerAnchor: Alignment.topRight,
        isGlobal: true,
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(animation),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            ),
          );
        });
  }

  Column detailColumn(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: AppWidgetSize.dimen_12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).canvasColor,
              fontFamily: AppConstants.fontName),
        ),
        Padding(
          padding: EdgeInsets.only(top: AppWidgetSize.dimen_5),
          child: TextWidget(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: AppWidgetSize.dimen_11,
                fontFamily: AppConstants.fontName),
          ),
        )
      ],
    );
  }

  bodyData(BuildContext context, Data watchlist, int index) {
    return MouseRegion(
      onEnter: (event) {
        watchlist.symbols[index].ttEligibility = true;
        isHover.value = true;
      },
      onExit: (event) {
        watchlist.symbols[index].ttEligibility = false;
        isHover.value = false;
      },
      child: ValueListenableBuilder(
          valueListenable: selectedsymbol,
          builder: (context, snapshots, _) {
            return ValueListenableBuilder<bool>(
                valueListenable: isHover,
                builder: (context, snapshot, _) {
                  return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: AppWidgetSize.dimen_10,
                          horizontal: AppWidgetSize.dimen_10),
                      margin:
                          EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_5),
                      decoration: BoxDecoration(
                          color: (selectedsymbol.value?.companyName ==
                                  watchlist.symbols[index].companyName)
                              ? Theme.of(context).dividerColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context).primaryColorLight,
                              width: 0.3)),
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        TextWidget(
                                          watchlist.symbols[index].dispSym
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontSize:
                                                      AppWidgetSize.dimen_12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: AppWidgetSize.dimen_8,
                                              top: AppWidgetSize.dimen_2),
                                          child: TextWidget(
                                            watchlist.symbols[index].sym.exc,
                                            size: AppWidgetSize.dimen_11,
                                            textalign: TextAlign.end,
                                            color:
                                                Theme.of(context).canvasColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: AppWidgetSize.dimen_5,
                                      color: Colors.transparent,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: AppWidgetSize.dimen_2),
                                      child: TextWidget(
                                        watchlist.symbols[index].companyName
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .inputDecorationTheme
                                                    .labelStyle
                                                    ?.color,
                                                fontSize:
                                                    AppWidgetSize.dimen_11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!watchlist.symbols[index].ttEligibility)
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Center(
                                        child: TextWidget(
                                          watchlist.symbols[index].excToken
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      AppWidgetSize.dimen_14),
                                        ),
                                      ),
                                      Divider(
                                        height: AppWidgetSize.dimen_5,
                                        color: Colors.transparent,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: AppWidgetSize.dimen_2),
                                        child: TextWidget(
                                          "${watchlist.symbols[index].change}(${watchlist.symbols[index].changePer}%)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontSize:
                                                      AppWidgetSize.dimen_13,
                                                  color: watchlist
                                                          .symbols[index].change
                                                          .contains("-")
                                                      ? Theme.of(context)
                                                          .snackBarTheme
                                                          .closeIconColor
                                                      : Colors.green),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                          if (watchlist.symbols[index].ttEligibility)
                            buysellHoverwidget(context, index)
                        ],
                      ));
                });
          }),
    );
  }

  Positioned buysellHoverwidget(BuildContext contex, int index) {
    return Positioned(
      right: AppWidgetSize.dimen_10,
      child: Row(
        children: [
          hoverbutton(
            index,
            contex,
            AppConstants.hoverBuy,
            () {
              controller?.reload();
              selectedsymbol.value = watchlist.symbols[index];
              showOrderpadpopup(contex);
            },
            Theme.of(context).focusColor,
            Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: AppWidgetSize.dimen_15,
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: AppWidgetSize.dimen_5,
          ),
          hoverbutton(index, contex, AppConstants.hoverSell, () {
            controller?.reload();
            selectedsymbol.value = watchlist.symbols[index];
            buySelected.value = false;
            showOrderpadpopup(contex);
          },
              Theme.of(context).snackBarTheme.closeIconColor,
              Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: AppWidgetSize.dimen_15,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  GestureDetector hoverbutton(int index, BuildContext contex, String title,
      Function()? onTap, Color? color, TextStyle? style) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: TextWidget(title, style: style),
      ),
    );
  }

  Widget loadData(BuildContext context) {
    return SizedBox(
      height: AppWidgetSize.fullHeight(context),
      width: AppWidgetSize.fullWidth(context) * 0.3 - AppWidgetSize.dimen_80,
      child: Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      )),
    );
  }
}

import 'dart:math';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/model/watchlist_model.dart';
import 'package:flutter_dashboard_web/ui/screens/popup_window.dart';
import 'package:flutter_dashboard_web/ui/widgets/search_widget.dart';
import 'package:flutter_dashboard_web/ui/widgets/swap_widget.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webviewx/webviewx.dart';

import '../../bloc/watchlist/watchlist_bloc.dart';
import '../../constants/appwidget_size.dart';
import '../widgets/horizontal_list_view.dart';
import '../widgets/market_depth_widget.dart';
import '../widgets/text_widget.dart';
import 'navigator_rail.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  Symbols? selectedsymbol;
  late WatchlistBloc watchlistBloc;
  Data searchWatchlist = Data(symbols: []);
  Data watchlist = Data(symbols: []);
  Random random = Random();
  ValueNotifier<String> selectedmyList =
      ValueNotifier<String>(AppConstants.myListData[0]);
  ValueNotifier<int> selectedindex = ValueNotifier<int>(0);
  ValueNotifier<bool> watchlistSelected = ValueNotifier<bool>(false);
  ValueNotifier<bool> buySelected = ValueNotifier<bool>(true);
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
                selectedsymbol ??= state.watchlist.response.data.symbols.first;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (selectedsymbol != null && !watchlistSelected.value) {
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
                                            backgroundColor: Colors.green,
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
                                            backgroundColor: Colors.red,
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
                                  initialContent:
                                      "https://www.tradingview.com/widgetembed/?frameElementId=tradingview_9c2ce&symbol=NASDAQ%3AAAPL&interval=D&hidesidetoolbar=1&symboledit=0&saveimage=1&toolbarbg=f1f3f6&studies=%5B%5D&theme=${AppUtils.isDarktheme ? "dark" : "light"}&style=1&timezone=Etc%2FUTC&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.tradingview.com&utm_medium=widget_new&utm_campaign=chart&utm_term=NASDAQ%3AAAPL",
                                  width:
                                      MediaQuery.of(context).size.width * 0.6 +
                                          AppWidgetSize.dimen_70,
                                  height: MediaQuery.of(context).size.height *
                                          0.55 -
                                      AppWidgetSize.dimen_20,
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6 +
                                          AppWidgetSize.dimen_70,
                                  height: MediaQuery.of(context).size.height *
                                          0.55 -
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
                    width: MediaQuery.of(context).size.width * 0.6 +
                        AppWidgetSize.dimen_70,
                    height: MediaQuery.of(context).size.height * 0.35 -
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
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height *
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
                                            dashRadius: 0.0,
                                            dashGapLength:
                                                AppWidgetSize.dimen_4,
                                            dashGapColor: Colors.transparent,
                                            dashGapRadius: 0.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                                        "Prev.Close", "202.70"),
                                                    detailColumn(
                                                        "Open", "205.90"),
                                                    detailColumn(
                                                        "High", "206.20"),
                                                    detailColumn(
                                                        "Low", "197.35"),
                                                  ],
                                                ),
                                              )
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

  Container doneStateWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3 - AppWidgetSize.dimen_80,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                          selectedsymbol = null;
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
            child: searchBox(searchController, "", "Search..", () {
              watchlistBloc.add(SortWatchlist(atoz, selectedmyList.value,
                  searchName: searchController.text));
            }),
          ),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: watchlist.symbols.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedsymbol = watchlist.symbols[index];
                      });
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
                    return PopupWindow(
                      buySelected: buySelected.value,
                      symbol: selectedsymbol!,
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
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Padding(
          padding: EdgeInsets.only(top: AppWidgetSize.dimen_5),
          child: TextWidget(
            value,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: AppWidgetSize.dimen_11),
          ),
        )
      ],
    );
  }

  Container bodyData(BuildContext context, Data watchlist, int index) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: AppWidgetSize.dimen_10,
            horizontal: AppWidgetSize.dimen_10),
        margin: EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_5),
        decoration: BoxDecoration(
            color: (selectedsymbol?.companyName ==
                    watchlist.symbols[index].companyName)
                ? Theme.of(context).dividerColor.withOpacity(0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Theme.of(context).primaryColorLight, width: 0.3)),
        alignment: Alignment.center,
        child: Row(
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
                        watchlist.symbols[index].dispSym.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: AppWidgetSize.dimen_12),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: AppWidgetSize.dimen_8,
                            top: AppWidgetSize.dimen_2),
                        child: TextWidget(
                          watchlist.symbols[index].sym.exc,
                          size: AppWidgetSize.dimen_11,
                          textalign: TextAlign.end,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: AppWidgetSize.dimen_5,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AppWidgetSize.dimen_2),
                    child: TextWidget(
                      watchlist.symbols[index].companyName.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .inputDecorationTheme
                              .labelStyle
                              ?.color,
                          fontSize: AppWidgetSize.dimen_11),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: TextWidget(
                      watchlist.symbols[index].excToken.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppWidgetSize.dimen_14),
                    ),
                  ),
                  Divider(
                    height: AppWidgetSize.dimen_5,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AppWidgetSize.dimen_2),
                    child: TextWidget(
                      "${watchlist.symbols[index].change}(${watchlist.symbols[index].changePer}%)",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: AppWidgetSize.dimen_13,
                          color: watchlist.symbols[index].change.contains("-")
                              ? Theme.of(context).snackBarTheme.closeIconColor
                              : Colors.green),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget loadData(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.3 - AppWidgetSize.dimen_80,
      child: Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      )),
    );
  }
}

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3 - AppWidgetSize.dimen_80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: AppWidgetSize.dimen_60,
              color: Theme.of(context).snackBarTheme.closeIconColor,
            ),
            const TextWidget(AppConstants.unknownError)
          ],
        ));
  }
}

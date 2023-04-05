import 'dart:math';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/model/watchlist_model.dart';
import 'package:flutter_dashboard_web/ui/screens/popup_window.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:webviewx/webviewx.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../../bloc/watchlist/watchlist_bloc.dart';
import '../widgets/horizontal_list_view.dart';
import '../widgets/marketDepth_widget.dart';
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
  ValueNotifier<int> selectedindex = ValueNotifier<int>(0);
  ValueNotifier<bool> watchlistSelected = ValueNotifier<bool>(false);
  bool atoz = false;
  bool ztoa = false;
  bool none = true;
  @override
  void initState() {
    watchlistBloc = BlocProvider.of<WatchlistBloc>(context);

    watchlistBloc.add(FetchWatchlist());

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

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                TextWidget("NIFTY 50",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .inputDecorationTheme
                                                .labelStyle
                                                ?.color)),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      TextWidget("14,696.50",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                      TextWidget(
                                        " (1.04%)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontSize: 13,
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
                                TextWidget("SENSEX",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .inputDecorationTheme
                                                .labelStyle
                                                ?.color)),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      TextWidget("48,690.80",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                      TextWidget(
                                        " (0.96%)",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontSize: 13,
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
                          TextWidget(
                            "My List",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 15),
                          ),
                          PopupMenuButton(
                           
                            onSelected: (item) {
                             
                            },

                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry>[
                              PopupMenuItem(
                                onTap: () {
                                  atoz = true;
                                  watchlistBloc.add(SortWatchlist(atoz));
                                },
                                value: atoz,
                                child: const Text('A - Z'),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  atoz = false;
                                  watchlistBloc.add(SortWatchlist(atoz));
                                 
                                },
                                value: !atoz,
                                child: const Text('Z - A'),
                              ),
                            ],
                          ),
                          /*  IconButton(
                              onPressed: () {
                                atoz = !atoz;
                                watchlistBloc.add(SortWatchlist(atoz));
                              },
                              icon: const Icon(
                                Icons.sort,
                                size: 20,
                              )) */
                        ],
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

                            //bodyData(context, watchlist, index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ValueListenableBuilder<bool>(
                          valueListenable: watchlistSelected,
                          builder: (context, selected, _) {
                            return selected
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          onPressed: () {
                                            showOrderpadpopup(context, true);
                                          },
                                          child: TextWidget(
                                            "BUY",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontStyle: FontStyle.normal),
                                          ),
                                          onPressed: () {
                                            showOrderpadpopup(context, false);
                                          },
                                          child: TextWidget(
                                            "SELL",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container();
                          }),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return WebViewX(
                            initialContent:
                                "https://www.tradingview.com/widgetembed/?frameElementId=tradingview_9c2ce&symbol=NASDAQ%3AAAPL&interval=D&hidesidetoolbar=1&symboledit=0&saveimage=1&toolbarbg=f1f3f6&studies=%5B%5D&theme=${state.theme ? "dark" : "light"}&style=1&timezone=Etc%2FUTC&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.tradingview.com&utm_medium=widget_new&utm_campaign=chart&utm_term=NASDAQ%3AAAPL",
                            width: MediaQuery.of(context).size.width * 0.6 + 70,
                            height:
                                MediaQuery.of(context).size.height * 0.55 - 20,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    padding: const EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width * 0.6 + 70,
                    height: MediaQuery.of(context).size.height * 0.35 - 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        horizontalListView(
                          fontSize: 14,
                          values: [
                            "Overview",
                            "Technicals",
                            "Futures",
                            "Options",
                            "News"
                          ],
                          selectedIndex: selectedindex.value,
                          isEnabled: true,
                          isRectShape: false,
                          callback: (value, index) {},
                          highlighterColor: Theme.of(context).primaryColor,
                          context: context,
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
                                          width: 10,
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3 -
                                              30,
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            lineLength: double.infinity,
                                            lineThickness: 1.0,
                                            dashLength: 4.0,
                                            dashColor:
                                                Theme.of(context).dividerColor,
                                            dashRadius: 0.0,
                                            dashGapLength: 4.0,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                child: TextWidget(
                                                  "Details",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(fontSize: 16),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
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
                                      ? const TextWidget("Technical")
                                      : index == 3
                                          ? const TextWidget("Futures")
                                          : index == 4
                                              ? const TextWidget("Technical")
                                              : const TextWidget("News");
                            })
                      ],
                    ) /* DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(icon: Text('Tab ONE')),
                            Tab(icon: Text('Tab TWO')),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Container(
                                child: const Text("tab 1"),
                              ),
                              Container(
                                child: const Text("tab 2"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), */
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showOrderpadpopup(BuildContext context, bool buySelected) {
    showAlignedDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return PointerInterceptor(
            intercepting: true,
            child:
                PopupWindow(buySelected: buySelected, symbol: selectedsymbol!),
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
          padding: const EdgeInsets.only(top: 5.0),
          child: TextWidget(
            value,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 11),
          ),
        )
      ],
    );
  }

  Container bodyData(BuildContext context, Data watchlist, int index) {
/*     double changePer = random.nextDouble() * 100 - 50.25;//haircut
    double per = random.nextDouble() * 100 - 50.25;//isin */

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
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
                            ?.copyWith(fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 2),
                        child: TextWidget(
                          watchlist.symbols[index].sym.exc,
                          size: 11,
                          textalign: TextAlign.end,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: TextWidget(
                      watchlist.symbols[index].companyName.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .inputDecorationTheme
                              .labelStyle
                              ?.color,
                          fontSize: 11),
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
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: TextWidget(
                      "${watchlist.symbols[index].haircut}(${watchlist.symbols[index].isin}%)",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 13,
                          color: watchlist.symbols[index].haircut.contains("-")
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
      width: MediaQuery.of(context).size.width * 0.3,
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
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 60,
          color: Colors.red[900],
        ),
        const Text("Unknown Error")
      ],
    ));
  }
}

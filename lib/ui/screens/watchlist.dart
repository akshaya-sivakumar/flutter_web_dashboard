import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/model/watchlist_model.dart';
import 'package:webviewx/webviewx.dart';

import '../../bloc/watchlist/watchlist_bloc.dart';
import '../widgets/horizontal_list_view.dart';
import '../widgets/text_widget.dart';
import 'navigator_rail.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late WatchlistBloc watchlistBloc;
  Data searchWatchlist = Data(symbols: []);
  Data watchlist = Data(symbols: []);
  Random random = Random();
  ValueNotifier<int> selectedindex = ValueNotifier<int>(0);
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
                watchlist = state.watchlist.response.data;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Theme.of(context).cardColor,
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
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: watchlist.symbols.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return bodyData(context, watchlist, index);

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
          Column(
            children: [
              WebViewX(
                initialContent:
                    "https://www.tradingview.com/widgetembed/?frameElementId=tradingview_9c2ce&symbol=NASDAQ%3AAAPL&interval=D&hidesidetoolbar=1&symboledit=0&saveimage=1&toolbarbg=f1f3f6&studies=%5B%5D&theme=light&style=1&timezone=Etc%2FUTC&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.tradingview.com&utm_medium=widget_new&utm_campaign=chart&utm_term=NASDAQ%3AAAPL",
                width: MediaQuery.of(context).size.width * 0.6 + 70,
                height: MediaQuery.of(context).size.height * 0.5 - 20,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  width: MediaQuery.of(context).size.width * 0.6 + 70,
                  height: MediaQuery.of(context).size.height * 0.45 - 20,
                  child: Column(
                    children: [
                      horizontalListView(
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
                                ? const TextWidget("overview")
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
        ],
      ),
    );
  }

  Container bodyData(BuildContext context, Data watchlist, int index) {
    double changePer = random.nextDouble() * 100 - 50.25;
    double per = random.nextDouble() * 100 - 50.25;
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).primaryColorLight)),
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
                      "${changePer.toStringAsFixed(2)}(${per.toStringAsFixed(2)}%)",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 13,
                          color: changePer.isNegative
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
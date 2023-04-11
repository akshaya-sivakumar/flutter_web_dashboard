import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';

class MarketDepthwidget extends StatelessWidget {
  const MarketDepthwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            "Market Depth",
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextWidget("BID",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              TextWidget("OFFER",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.w600))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: [
              TableRow(children: [
                Text("Bid",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 13, color: Theme.of(context).canvasColor)),
                Text(
                  "Orders",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13, color: Theme.of(context).canvasColor),
                ),
                Text(
                  "Qty",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13, color: Theme.of(context).canvasColor),
                ),
                Text(
                  "Offer",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13, color: Theme.of(context).canvasColor),
                ),
                Text(
                  "Orders",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13, color: Theme.of(context).canvasColor),
                ),
                Text(
                  "Qty",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 13, color: Theme.of(context).canvasColor),
                ),
              ])
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: List.generate(
                5,
                (index) => TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "1000",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .snackBarTheme
                                      .actionTextColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "0",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .snackBarTheme
                                      .actionTextColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "185.25",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .snackBarTheme
                                      .actionTextColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "1000",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "0",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "185.25",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.green),
                        ),
                      ),
                    ])),
          ),
        ],
      ),
    );
  }
}

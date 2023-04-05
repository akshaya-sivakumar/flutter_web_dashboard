import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/main.dart';
import 'package:flutter_dashboard_web/model/watchlist_model.dart';
import 'package:flutter_dashboard_web/ui/widgets/circular_toggle.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../widgets/material_switch.dart';
import '../widgets/textfield_widget.dart';

class PopupWindow extends StatefulWidget {
  final Symbols symbol;
  final bool buySelected;
  const PopupWindow({
    super.key,
    required this.symbol,
    required this.buySelected,
  });

  @override
  State<PopupWindow> createState() => _PopupWindowState();
}

class _PopupWindowState extends State<PopupWindow> {
  TextEditingController qtycontroller = TextEditingController(text: "0");
  TextEditingController pricecontroller = TextEditingController(text: "0");
  TextEditingController disQtycontroller = TextEditingController(text: "0");
  TextEditingController stopplossTriggercontroller =
      TextEditingController(text: "0");
  List productList = ["Delivery", "Intraday", "E-margin", "Cover"];
  String selectedProducttype = "";
  @override
  void initState() {
    selectedProducttype = productList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return StatefulBuilder(builder: (context, setstate) {
          return Container(
              margin: const EdgeInsets.only(top: 41),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height,
              color: state.theme
                  ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8)
                  : HexColor("#f1f1f6"),
              child: Scaffold(
                  backgroundColor: state.theme
                      ? Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.8)
                      : HexColor("#f1f1f6"),
                  bottomNavigationBar: BottomAppBar(
                    color: widget.buySelected
                        ? HexColor("#03ad7a")
                        : Theme.of(context).snackBarTheme.closeIconColor,
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: TextWidget(
                          widget.buySelected ? "BUY" : "SELL",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    appRoute.pop();
                                  },
                                  child: const Icon(Icons.close)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextWidget(widget.symbol.companyName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DottedLine(
                            dashColor: Theme.of(context).dividerColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextWidget(
                                        widget.symbol.baseSym,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontSize: 14),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, top: 2),
                                        child: TextWidget(
                                          widget.symbol.sym.exc,
                                          size: 10,
                                          textalign: TextAlign.end,
                                          color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          widget.symbol.excToken,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 13),
                                        ),
                                        TextWidget(
                                          " ${widget.symbol.haircut}(${widget.symbol.isin}%)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              MaterialSwitch(
                                inactiveTrackColor: Colors.green,
                                activeTrackColor: Colors.red,
                                activeColor: Colors.white,
                                value: !widget.buySelected,
                                onChanged: (value) {},
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Theme.of(context).dividerColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextWidget(
                            "Product",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context).canvasColor),
                          ),
                        ),
                        CircularButtonToggleWidget(
                            key: const Key(""),
                            value: selectedProducttype,
                            fontSize: 13,
                            paddingEdgeInsets: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            toggleButtonlist: productList,
                            toggleChanged: (value) {
                              setstate(() {});
                            },
                            toggleButtonOnChanged: (value) {
                              setstate(() {
                                selectedProducttype = value;
                              });
                            },
                            enabledButtonlist: [selectedProducttype],
                            defaultSelected: selectedProducttype,
                            activeButtonColor: Theme.of(context).primaryColor,
                            activeTextColor: Colors.white,
                            inactiveButtonColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            inactiveTextColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle
                                    ?.color ??
                                Colors.grey,
                            borderColor: Theme.of(context).canvasColor,
                            context: context),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextWidget(
                                "Pay fill and get shares in your DP Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 11,
                                        color: Theme.of(context).canvasColor),
                                textalign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextfieldWidget(
                                controller: qtycontroller,
                                label: "Quantity",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextfieldWidget(
                                controller: pricecontroller,
                                label: 'Price',
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextfieldWidget(
                                controller: disQtycontroller,
                                label: "Disclosed Qty",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextfieldWidget(
                                controller: stopplossTriggercontroller,
                                label: 'Stoploss Trigger Price',
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )));
        });
      },
    );
  }
}

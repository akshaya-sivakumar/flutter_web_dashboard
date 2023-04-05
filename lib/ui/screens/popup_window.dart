import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
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
  String selectedValidity = "DAY";
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
              margin: EdgeInsets.only(top: AppWidgetSize.dimen_41),
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
                      height: AppWidgetSize.dimen_40,
                      child: Center(
                        child: TextWidget(
                          widget.buySelected ? "BUY" : "SELL",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: AppWidgetSize.dimen_15),
                        ),
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppWidgetSize.dimen_20,
                        vertical: AppWidgetSize.dimen_20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppWidgetSize.dimen_10),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppWidgetSize.dimen_10),
                                child: TextWidget(widget.symbol.companyName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontSize: AppWidgetSize.dimen_15)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppWidgetSize.dimen_10),
                          child: DottedLine(
                            dashColor: Theme.of(context).dividerColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppWidgetSize.dimen_10),
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
                                            ?.copyWith(
                                                fontSize:
                                                    AppWidgetSize.dimen_14),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: AppWidgetSize.dimen_5,
                                            top: AppWidgetSize.dimen_2),
                                        child: TextWidget(
                                          widget.symbol.sym.exc,
                                          size: AppWidgetSize.dimen_10,
                                          textalign: TextAlign.end,
                                          color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: AppWidgetSize.dimen_8),
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          widget.symbol.excToken,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize:
                                                      AppWidgetSize.dimen_13),
                                        ),
                                        TextWidget(
                                          " ${widget.symbol.change}(${widget.symbol.changePer}%)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      AppWidgetSize.dimen_11),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  MaterialSwitch(
                                    inactiveTrackColor: HexColor("#03ad7a"),
                                    activeTrackColor: Theme.of(context)
                                        .snackBarTheme
                                        .closeIconColor,
                                    activeColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    value: !widget.buySelected,
                                    onChanged: (value) {},
                                  ),
                                  widget.buySelected
                                      ? Positioned(
                                          right: AppWidgetSize.dimen_13,
                                          child: TextWidget(
                                              AppConstants.buySmall,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: AppWidgetSize
                                                          .dimen_12,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor)))
                                      : Positioned(
                                          left: AppWidgetSize.dimen_13,
                                          child: TextWidget(
                                              AppConstants.sellSmall,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                  fontSize:
                                                      AppWidgetSize.dimen_12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor)))
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: AppWidgetSize.dimen_1,
                          color: Theme.of(context).dividerColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: AppWidgetSize.dimen_10),
                          child: TextWidget(
                            AppConstants.product,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: AppWidgetSize.dimen_12,
                                    color: Theme.of(context).canvasColor),
                          ),
                        ),
                        CircularButtonToggleWidget(
                            key: const Key(""),
                            value: selectedProducttype,
                            fontSize: AppWidgetSize.dimen_13,
                            paddingEdgeInsets: EdgeInsets.symmetric(
                                vertical: AppWidgetSize.dimen_10,
                                horizontal: AppWidgetSize.dimen_15),
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
                                Theme.of(context).canvasColor,
                            borderColor: Theme.of(context).canvasColor,
                            context: context),
                        Padding(
                          padding: EdgeInsets.only(top: AppWidgetSize.dimen_5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextWidget(
                                AppConstants.pdgTypestatement,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: AppWidgetSize.dimen_11,
                                        color: Theme.of(context).canvasColor),
                                textalign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: AppWidgetSize.dimen_20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextfieldWidget(
                                controller: qtycontroller,
                                label: AppConstants.qty,
                              ),
                              SizedBox(
                                width: AppWidgetSize.dimen_10,
                              ),
                              TextfieldWidget(
                                controller: pricecontroller,
                                label: AppConstants.price,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: AppWidgetSize.dimen_20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextfieldWidget(
                                controller: disQtycontroller,
                                label: AppConstants.disclosedQty,
                              ),
                              SizedBox(
                                width: AppWidgetSize.dimen_10,
                              ),
                              TextfieldWidget(
                                controller: stopplossTriggercontroller,
                                label: AppConstants.stoplossTrigger,
                              )
                            ],
                          ),
                        ),
                        validityWidget(context)
                      ],
                    ),
                  )));
        });
      },
    );
  }

  Padding validityWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppWidgetSize.dimen_20, left: AppWidgetSize.dimen_20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            AppConstants.validity,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: AppWidgetSize.dimen_12),
          ),
          Container(
            margin: EdgeInsets.only(
                right: AppWidgetSize.dimen_10, top: AppWidgetSize.dimen_10),
            height: AppWidgetSize.dimen_40,
            width: AppWidgetSize.dimen_170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppWidgetSize.dimen_5),
                border: Border.all(color: Theme.of(context).canvasColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 56.5,
                    alignment: Alignment.center,
                    height: AppWidgetSize.dimen_40,
                    decoration: BoxDecoration(
                        color: selectedValidity == AppConstants.day
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        border: Border(
                            right: BorderSide(
                                color: Theme.of(context).canvasColor))),
                    child: TextWidget(AppConstants.day,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: selectedValidity == AppConstants.day
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color)),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: selectedValidity == AppConstants.ioc
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    width: AppWidgetSize.dimen_55,
                    alignment: Alignment.center,
                    height: AppWidgetSize.dimen_40,
                    child: TextWidget(AppConstants.ioc,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: selectedValidity == AppConstants.ioc
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color)),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 56.5,
                    alignment: Alignment.center,
                    height: AppWidgetSize.dimen_40,
                    decoration: BoxDecoration(
                        color: selectedValidity == AppConstants.gtc
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        border: Border(
                            left: BorderSide(
                                color: Theme.of(context).canvasColor))),
                    child: TextWidget(AppConstants.gtc,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: selectedValidity == AppConstants.gtc
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

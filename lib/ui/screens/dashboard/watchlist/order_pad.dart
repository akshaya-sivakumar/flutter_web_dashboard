import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/main.dart';
import 'package:flutter_dashboard_web/model/watchlist/watchlist_model.dart';
import 'package:flutter_dashboard_web/ui/widgets/circular_toggle.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';

import '../../../widgets/material_switch.dart';
import '../../../widgets/textfield_widget.dart';

class OrderPadWindow extends StatefulWidget {
  final Symbols symbol;
  final bool buySelected;
  final Function(bool)? onChanged;
  const OrderPadWindow({
    super.key,
    required this.symbol,
    required this.buySelected,
    this.onChanged,
  });

  @override
  State<OrderPadWindow> createState() => _OrderPadWindowState();
}

class _OrderPadWindowState extends State<OrderPadWindow> {
  TextEditingController qtycontroller = TextEditingController(text: "0");
  TextEditingController pricecontroller = TextEditingController(text: "0");
  TextEditingController disQtycontroller = TextEditingController(text: "0");
  TextEditingController stopplossTriggercontroller =
      TextEditingController(text: "0");
  ValueNotifier<String> selectedProducttype = ValueNotifier<String>("");

  ValueNotifier<String> selectedValidity =
      ValueNotifier<String>(AppConstants.day);

  @override
  void initState() {
    selectedProducttype.value = AppConstants.productList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppWidgetSize.fullWidth(context) * 0.3,
        height: AppWidgetSize.fullHeight(context),
        color: Theme.of(context).cardColor,
        child: Scaffold(
            backgroundColor: Theme.of(context).cardColor,
            bottomNavigationBar: BottomAppBar(
              color: widget.buySelected
                  ? Theme.of(context).focusColor
                  : Theme.of(context).snackBarTheme.closeIconColor,
              child: SizedBox(
                height: AppWidgetSize.dimen_40,
                child: Center(
                  child: TextWidget(
                    widget.buySelected ? AppConstants.buy : AppConstants.sell,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
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
                    padding:
                        EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_10),
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
                                  ?.copyWith(fontSize: AppWidgetSize.dimen_15)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_10),
                    child: DottedLine(
                      dashColor: Theme.of(context).dividerColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: AppWidgetSize.dimen_10),
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
                                          fontSize: AppWidgetSize.dimen_14),
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
                              padding:
                                  EdgeInsets.only(top: AppWidgetSize.dimen_8),
                              child: Row(
                                children: [
                                  TextWidget(
                                    widget.symbol.excToken,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            fontSize: AppWidgetSize.dimen_13),
                                  ),
                                  TextWidget(
                                    " ${widget.symbol.change}(${widget.symbol.changePer}%)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: widget.symbol.change
                                                    .contains("-")
                                                ? Theme.of(context)
                                                    .snackBarTheme
                                                    .closeIconColor
                                                : Theme.of(context).focusColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: AppWidgetSize.dimen_11),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Theme(
                              data: ThemeData(
                                  scaffoldBackgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: MaterialSwitch(
                                inactiveTrackColor:
                                    Theme.of(context).focusColor,
                                activeTrackColor: Theme.of(context)
                                    .snackBarTheme
                                    .closeIconColor,
                                activeColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                inactiveThumbColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                value: !widget.buySelected,
                                onChanged: widget.onChanged,
                              ),
                            ),
                            widget.buySelected
                                ? Positioned(
                                    right: AppWidgetSize.dimen_13,
                                    child: TextWidget(AppConstants.buySmall,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    AppWidgetSize.dimen_12,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor)))
                                : Positioned(
                                    left: AppWidgetSize.dimen_13,
                                    child: TextWidget(AppConstants.sellSmall,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
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
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: AppWidgetSize.dimen_12,
                          color: Theme.of(context).canvasColor),
                    ),
                  ),
                  ValueListenableBuilder<String>(
                      valueListenable: selectedProducttype,
                      builder: (context, snapshot, _) {
                        return CircularButtonToggleWidget(
                            key: const Key(""),
                            value: selectedProducttype.value,
                            fontSize: AppWidgetSize.dimen_13,
                            paddingEdgeInsets: EdgeInsets.symmetric(
                                vertical: AppWidgetSize.dimen_10,
                                horizontal: AppWidgetSize.dimen_15),
                            toggleButtonlist: AppConstants.productList,
                            toggleChanged: (value) {},
                            toggleButtonOnChanged: (value) {
                              selectedProducttype.value = value;
                            },
                            enabledButtonlist: [selectedProducttype],
                            defaultSelected: selectedProducttype.value,
                            activeButtonColor: Theme.of(context).primaryColor,
                            activeTextColor: Theme.of(context).shadowColor,
                            inactiveButtonColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            inactiveTextColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle
                                    ?.color ??
                                Theme.of(context).canvasColor,
                            borderColor: Theme.of(context).canvasColor,
                            context: context);
                      }),
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
  }

  validityWidget(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: selectedValidity,
        builder: (context, snapshot, _) {
          return Padding(
            padding: EdgeInsets.only(
                top: AppWidgetSize.dimen_20, left: AppWidgetSize.dimen_15),
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
                      right: AppWidgetSize.dimen_10,
                      top: AppWidgetSize.dimen_10),
                  height: AppWidgetSize.dimen_40,
                  width: AppWidgetSize.dimen_170,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppWidgetSize.dimen_5),
                      border: Border.all(color: Theme.of(context).canvasColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectedValidity.value = AppConstants.day;
                        },
                        child: Container(
                          width: 56.5,
                          alignment: Alignment.center,
                          height: AppWidgetSize.dimen_40,
                          decoration: BoxDecoration(
                              color: selectedValidity.value == AppConstants.day
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
                                      color: selectedValidity.value ==
                                              AppConstants.day
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.color)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedValidity.value = AppConstants.ioc;
                        },
                        child: Container(
                          color: selectedValidity.value == AppConstants.ioc
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
                                      color: selectedValidity.value ==
                                              AppConstants.ioc
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                          : Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.color)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedValidity.value = AppConstants.gtc;
                        },
                        child: Container(
                          width: 56.5,
                          alignment: Alignment.center,
                          height: AppWidgetSize.dimen_40,
                          decoration: BoxDecoration(
                              color: selectedValidity.value == AppConstants.gtc
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
                                      color: selectedValidity.value ==
                                              AppConstants.gtc
                                          ? Theme.of(context)
                                              .scaffoldBackgroundColor
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
        });
  }
}

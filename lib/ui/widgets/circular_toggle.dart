import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/ui/widgets/text_widget.dart';

import '../../constants/appwidget_size.dart';

// ignore: must_be_immutable
class CircularButtonToggleWidget extends StatefulWidget {
  final String value;
  final List<dynamic>? buttonNoList;
  final List<dynamic> toggleButtonlist;
  final List<String>? superScript;

  final List<dynamic>? enabledButtonlist;
  final String defaultSelected;
  final Function toggleButtonOnChanged;
  Function? toggleChanged;
  final Color activeButtonColor;
  final Color activeTextColor;
  final Color inactiveButtonColor;
  final Color inactiveTextColor;
  final bool isDisabled;
  final EdgeInsets? marginEdgeInsets;
  final EdgeInsets? paddingEdgeInsets;
  final bool isBorder;
  final bool islightBorderColor;
  final BuildContext context;
  final double fontSize;
  Color? borderColor;
  bool isResetSelectionAllowed;
  final List<dynamic>? activeButtons;
  final List<String>? selectedButtons;
  final double spacing;
  CircularButtonToggleWidget({
    required Key key,
    required this.value,
    this.buttonNoList,
    required this.toggleButtonlist,
    required this.toggleButtonOnChanged,
    required this.enabledButtonlist,
    required this.defaultSelected,
    required this.activeButtonColor,
    required this.activeTextColor,
    required this.inactiveButtonColor,
    required this.inactiveTextColor,
    this.marginEdgeInsets,
    this.paddingEdgeInsets,
    this.isDisabled = false,
    this.isBorder = true,
    this.islightBorderColor = false,
    required this.context,
    this.fontSize = 17,
    this.borderColor,
    this.isResetSelectionAllowed = false,
    this.toggleChanged,
    this.activeButtons,
    this.selectedButtons,
    this.superScript,
    this.spacing = 0,
  }) : super(key: key);

  @override
  CircularButtonToggleWidgetState createState() =>
      CircularButtonToggleWidgetState();
}

class CircularButtonToggleWidgetState
    extends State<CircularButtonToggleWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context = widget.context;
    widget.borderColor ??= Theme.of(context).canvasColor;
    return Wrap(
      direction: Axis.horizontal,
      spacing: widget.spacing,
      children:
          List<Widget>.generate(widget.toggleButtonlist.length, (int index) {
        final dynamic item = widget.toggleButtonlist[index];

        String itemname = '';
        late double opacityvalue;

        if (item is String) {
          // debugPrint('String type');
          itemname = item;
          if ((widget.isDisabled && item != widget.value) ||
              (widget.enabledButtonlist != null &&
                  !widget.enabledButtonlist!.contains(item))) {
            // opacityvalue = 0.5;

            opacityvalue = 1.0;
          } else {
            opacityvalue = 1.0;
          }
        } else if (item is Map) {
          itemname = item.keys.elementAt(0);
          if (widget.isDisabled && item[itemname] != widget.value) {
            opacityvalue = 0.5;
          } else {
            opacityvalue = (item[itemname] == '1') ? 1.0 : 0.5;
          }
        }
        bool isActive = widget.value == itemname;
        if (widget.activeButtons != null) {
          isActive = (widget.activeButtons![index].status == true);
        }
        if (widget.selectedButtons != null &&
            widget.selectedButtons!.isNotEmpty) {
          isActive = widget.selectedButtons!.contains(itemname);
        }
        String? buttonNo;
        if (widget.buttonNoList != null) {
          buttonNo = widget.buttonNoList?.elementAt(index);
        }

        return Opacity(
          opacity: opacityvalue,
          child: InkWell(
            onTap: () {
              if (opacityvalue == 1.0) {
                if (!widget.isDisabled && !isActive ||
                    widget.isResetSelectionAllowed) {
                  widget.toggleButtonOnChanged(itemname);
                  if (widget.toggleChanged != null) {
                    widget.toggleChanged!(index);
                  }
                } else if (widget.activeButtons != null) {
                  widget.toggleButtonOnChanged(itemname);
                  if (widget.toggleChanged != null) {
                    widget.toggleChanged!(index);
                  }
                } else if (widget.selectedButtons != null &&
                    widget.selectedButtons!.isNotEmpty) {
                  widget.toggleButtonOnChanged(itemname);
                  if (widget.toggleChanged != null) {
                    widget.toggleChanged!(index);
                  }
                }
              }
            },
            child: buildRoundedTextButton(
              isActive,
              context,
              itemname,
              widget.marginEdgeInsets,
              widget.paddingEdgeInsets,
              index,
              buttonNo: buttonNo,
            ),
          ),
        );
      }).toList(),
    );
  }

  Container buildRoundedTextButton(
    bool isActive,
    BuildContext context,
    String itemname,
    EdgeInsets? marginEdgeInsets,
    EdgeInsets? paddingEdgeInsets,
    int index, {
    String? buttonNo,
  }) {
    return Container(
      margin: marginEdgeInsets ?? buildMarginEdgeInsets(),
      padding: paddingEdgeInsets ?? buildPaddingEdgeInsets(),
      decoration: BoxDecoration(
        color: isActive ? widget.activeButtonColor : widget.inactiveButtonColor,
        borderRadius: BorderRadius.circular(
          AppWidgetSize.dimen_20,
        ),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: (widget.buttonNoList == null)
          ? RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headlineMedium!
                      .copyWith(
                        fontWeight:
                            isActive ? FontWeight.w500 : FontWeight.w500,
                        color: isActive
                            ? widget.activeTextColor
                            : widget.inactiveTextColor,
                        fontSize: widget.fontSize,
                      ),
                  children: [
                  TextSpan(
                    text: itemname.toString(),
                  ),
                  if ((widget.superScript?.isNotEmpty ?? false) &&
                      index < (widget.superScript?.length ?? 0))
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
                        child: Transform.translate(
                          offset: Offset(0.0, -AppWidgetSize.dimen_10),
                          child: Text(
                            widget.superScript?[index] ?? "",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: isActive
                                      ? FontWeight.w500
                                      : FontWeight.w500,
                                  color: isActive
                                      ? widget.activeTextColor
                                      : widget.inactiveTextColor,
                                  fontSize: AppWidgetSize.dimen_10,
                                ),
                          ),
                        ),
                      ),
                    ),
                ]))
          : Row(
              children: [
                TextWidget(
                  itemname.toString(),
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headlineMedium!
                      .copyWith(
                        fontWeight:
                            isActive ? FontWeight.w500 : FontWeight.w500,
                        color: isActive
                            ? widget.activeTextColor
                            : widget.inactiveTextColor,
                        fontSize: widget.fontSize,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextWidget(
                        buttonNo.toString(),
                        textalign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 12,
                            ), /*  textAlign: TextAlign.center */
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  EdgeInsets buildPaddingEdgeInsets() {
    return EdgeInsets.fromLTRB(
      AppWidgetSize.dimen_14,
      AppWidgetSize.dimen_6,
      AppWidgetSize.dimen_14,
      AppWidgetSize.dimen_6,
    );
  }

  EdgeInsets buildMarginEdgeInsets() {
    return EdgeInsets.only(
      right: AppWidgetSize.dimen_6,
      top: AppWidgetSize.dimen_6,
    );
  }
}

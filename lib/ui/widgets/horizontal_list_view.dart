import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';

import '../../constants/appwidget_size.dart';

Widget horizontalListView({
  required var values,
  required int selectedIndex,
  bool isRectShape = false,
  bool isEnabled = true,
  required Function callback,
  Function? onLongPress,
  bool? shirinkWrap,
  required Color highlighterColor,
  required BuildContext context,
  double vertical = 4,
  double fontSize = 16,
  double height = 34,
}) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: vertical,
      horizontal: 0,
    ),
    height: height,
    width: AppWidgetSize.fullWidth(context) - 100,
    child: ListView.builder(
      shrinkWrap: shirinkWrap ?? false,
      scrollDirection: Axis.horizontal,
      itemCount: values.length,
      itemBuilder: (context, index) {
        String value = values[index];
        final double valueLabelWidth = value == ''
            ? 5
            : value.textSize(
                value,
                Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).canvasColor,
                    ),
              );
        return GestureDetector(
          onTap: () {
            if (selectedIndex != index) {
              if (isEnabled) callback(value, index);
            }
          },
          onLongPress: () {
            if (onLongPress != null) {
              if (isEnabled) onLongPress(value);
            }
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppWidgetSize.dimen_4,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: AppWidgetSize.dimen_4,
                  ),
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: index == selectedIndex
                              ? highlighterColor
                              : Theme.of(context).canvasColor,
                          fontSize:
                              fontSize, /* fontFamily: GoogleFonts.aboreto().fontFamily */
                        ),
                    key: Key(value),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: AppWidgetSize.dimen_4,
                ),
                width: valueLabelWidth,
                height: AppWidgetSize.dimen_3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == selectedIndex
                      ? highlighterColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(
                    AppWidgetSize.dimen_20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

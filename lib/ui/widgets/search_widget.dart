import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/main.dart';

var showPassword = true;
TextField searchBox(controller, label, hint, function) {
  return TextField(
    textAlign: TextAlign.start,
    onChanged: (v) {
      function();
    },
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: () {
              if (controller.text.toString().isNotEmpty) {
                controller.text = "";
              }
              function();
            },
            child: controller.text == ""
                ? const Icon(
                    Icons.search,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.cancel,
                    color: Theme.of(appRoute.navigatorKey.currentContext!)
                        .primaryColor,
                  )),
        label: Text(label),
        hintText: "Search...",
        hintStyle: TextStyle(
            fontSize: AppWidgetSize.dimen_13,
            color: Theme.of(appRoute.navigatorKey.currentContext!).canvasColor),
        labelStyle: TextStyle(
            fontSize: AppWidgetSize.dimen_14,
            color: Theme.of(appRoute.navigatorKey.currentContext!).canvasColor),
        contentPadding: EdgeInsets.symmetric(
            vertical: AppWidgetSize.dimen_20,
            horizontal: AppWidgetSize.dimen_10),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                width: 0.4,
                color: Theme.of(appRoute.navigatorKey.currentContext!)
                    .dividerColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 0.4,
                color: Theme.of(appRoute.navigatorKey.currentContext!)
                    .dividerColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 0.4,
                color: Theme.of(appRoute.navigatorKey.currentContext!)
                    .dividerColor))),
  );
}

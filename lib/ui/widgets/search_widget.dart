import 'package:flutter/material.dart';
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
                : const Icon(
                    Icons.cancel,
                    // color: AppColors.themeColor,
                  )),
        label: Text(label),
        hintText: hint == "" ? 'Enter here' : hint,
        hintStyle: TextStyle(
            fontSize: 13,
            color: Theme.of(appRoute.navigatorKey.currentContext!).canvasColor),
        labelStyle: TextStyle(
            fontSize: 14,
            color: Theme.of(appRoute.navigatorKey.currentContext!).canvasColor),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/constants/app_constants.dart';

import '../constants/appwidget_size.dart';

const Color appPrimarycolor = Color(0xFF5E50AD);
const Color appPrimaryLightcolor = Color(0xFFCFCBE7);
const Color appBackgroundcolor = Color(0xFF1C1D28);
const Color appBackgroundcolorSecondary = Color(0xFF242533);
const Color appTextcolor = Color(0xFFFFFFFF);
const Color appAccentcolor = Color(0xFF999999);
const Color appBordercolor = Color(0xFF3E3F50);
const Color appAccentTextcolor = Color(0xFFA2A2A5);
const Color applightAccentTextcolor = Color(0xFFA2A2A5);
const Color appErrorcolor = Color(0xFFF8313E);
const Color appIconcolor = Color(0xFFFFFFFF);
const Color appOverlinecolor = appAccentTextcolor;

//ref from old app need to change it or remove it
const Color labelColor = Color(0xFFA2A2A2);
const Color appInputFillcolor = Color(0xFF222337);
const Color snackbarBackgroundColor = Color(0xFF222337);
const Color bgColor = Color(0xFFFFFFFF);
const Color appFocusInputBorderColor = Color(0xFF212335);
const Color appAccentIconcolor = Color(0xFF9798A1);

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: appPrimarycolor,
    primaryColorLight: appPrimaryLightcolor,
    canvasColor: appAccentcolor,
    dialogBackgroundColor: appBackgroundcolorSecondary,
    scaffoldBackgroundColor: appBackgroundcolorSecondary,
    fontFamily: AppConstants.fontName,
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline6Size,
        fontWeight: FontWeight.w600,
        color: appPrimarycolor,
      ),
      headlineSmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline5Size,
        fontWeight: FontWeight.w600,
        color: appPrimarycolor,
      ),
      headlineMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline4Size,
        fontWeight: FontWeight.w500,
        color: appPrimarycolor,
      ),
      displaySmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline3Size,
        fontWeight: FontWeight.w400,
        color: appPrimarycolor,
      ),
      displayMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline2Size,
        fontWeight: FontWeight.w500,
        color: appPrimarycolor,
      ),
      displayLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline1Size,
        fontWeight: FontWeight.w700,
        color: appPrimarycolor,
      ),
      titleMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.subtitle1Size,
        fontWeight: FontWeight.w600,
        color: appPrimarycolor,
      ),
      bodyMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.bodyText2Size,
        fontWeight: FontWeight.w400,
        color: appPrimarycolor,
      ),
      bodyLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.bodyText1Size,
        fontWeight: FontWeight.w400,
        color: appPrimarycolor,
      ),
      labelLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.buttonTextSize,
        fontWeight: FontWeight.w500,
        color: appPrimarycolor,
      ),
      bodySmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.captionSize,
        fontWeight: FontWeight.w600,
        color: appPrimarycolor,
      ),
      labelSmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.bodyText2Size,
        fontWeight: FontWeight.w500,
        color: appPrimarycolor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline6Size,
        fontWeight: FontWeight.w600,
        color: appTextcolor,
      ),
      headlineSmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline5Size,
        fontWeight: FontWeight.w600,
        color: appTextcolor,
      ),
      headlineMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline4Size,
        fontWeight: FontWeight.w500,
        color: appTextcolor,
      ),
      displaySmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline3Size,
        fontWeight: FontWeight.w400,
        color: appTextcolor,
      ),
      displayMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline2Size,
        fontWeight: FontWeight.w500,
        color: appTextcolor,
      ),
      displayLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline1Size,
        fontWeight: FontWeight.w700,
        color: appTextcolor,
      ),
      titleMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.subtitle1Size,
        fontWeight: FontWeight.w300,
        color: appTextcolor,
      ),
      bodyMedium: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.bodyText2Size,
        fontWeight: FontWeight.w400,
        color: appTextcolor,
      ),
      bodyLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.bodyText1Size,
        fontWeight: FontWeight.w400,
        color: appTextcolor,
      ),
      labelLarge: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.buttonTextSize,
        color: appPrimarycolor,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.captionSize,
        fontWeight: FontWeight.w500,
        color: appTextcolor,
      ),
      labelSmall: TextStyle(
        letterSpacing: 0,
        fontSize: AppWidgetSize.headline8Size,
        fontWeight: FontWeight.w500,
        color: appOverlinecolor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: appBackgroundcolor,
      elevation: 0.0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(bottom: 3),
      labelStyle: TextStyle(
        height: 0.6,
        letterSpacing: 0,
        fontSize: AppWidgetSize.inputLabelSize,
        // fontWeight: FontWeight.w600,
        color: labelColor,
      ),
      fillColor: appInputFillcolor,
      isDense: true,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: appFocusInputBorderColor,
          width: 1,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: appFocusInputBorderColor,
          width: 1,
        ),
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: appPrimarycolor,
    ),
    iconTheme: const IconThemeData(
      color: appIconcolor,
    ),
    dividerColor: appBordercolor,
    buttonTheme: ButtonThemeData(
      buttonColor: appPrimarycolor,
      shape: RoundedRectangleBorder(
        borderRadius: AppWidgetSize.buttonBorderRadius,
      ),
      focusColor: appBackgroundcolorSecondary,
      height: AppWidgetSize.buttonHeight,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: appBackgroundcolorSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: snackbarBackgroundColor,
    ),
    /*  colorScheme: ColorScheme(error: appErrorcolor),
    colorScheme: ColorScheme(background: appBackgroundcolor), */
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return appPrimarycolor;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return appPrimarycolor;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return appPrimarycolor;
        }
        return null;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return appPrimarycolor;
        }
        return null;
      }),
    ),
    // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: appAccentcolor),
  );
}

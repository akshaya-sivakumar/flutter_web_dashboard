import 'package:flutter/material.dart';

import '../constants/appwidget_size.dart';
import '../constants/sbi_constants.dart';

const Color appPrimarycolor = Color(0xFF5E50AD);
const Color appPrimaryLightcolor = Color(0xFFCFCBE7);
const Color appBackgroundcolor = Color(0xFFF1F1F6);
const Color appBackgroundcolorSecondary = Color(0xFFFFFFFF);
const Color appAccentcolor = Color(0xFF999999);
const Color appBordercolor = Color(0xFFD9D9D9);
const Color appTextcolor = Color(0xFF2B2B2B);
const Color appAccentTextcolor = Color(0xFF999999);
const Color applightAccentTextcolor = Color(0xff00000099);
const Color appOverlinecolor = Color(0xFF666666);
const Color appErrorcolor = Color(0xFFF8313E);
const Color appIconcolor = Color(0xFF727275);
const Color appMultilegColor = Color(0xFFF7F7F7);

//ref from old app need to change it or remove it
const Color appAccentIconcolor = Color(0xFF717880);
const Color labelColor = Color(0xFF666666);
const Color appInputFillcolor = Color(0xFFF1F1F1);
const Color snackbarBackgroundColor = Color(0xFFDEDEDE);
const Color appFocusInputBorderColor = Color(0xFFEAEBEC);

ThemeData lightTheme() {
  return ThemeData(
    //cursorColor: appPrimarycolor,
    brightness: Brightness.light,
    primaryColor: appPrimarycolor,
    primaryColorLight: appPrimaryLightcolor,
    canvasColor: appAccentcolor,
    dialogBackgroundColor: appBackgroundcolorSecondary,
    scaffoldBackgroundColor: appBackgroundcolorSecondary,
    fontFamily: SbiConstants.FONT_NAME,
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
        color: appTextcolor,
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
        closeIconColor: appErrorcolor),
    /*  colorScheme: ColorScheme(
        error: appErrorcolor,
        brightness: Brightness.light,
        primary: Colors.white,
        background: Colors.red,onPrimary: Colors.red,secondary: Colors.red,onSecondary: Colors.red,onError: Colors.red), */

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
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: appAccentcolor),
  );
}

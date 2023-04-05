import 'package:flutter/material.dart';

class AppWidgetSize {
  // Minumum screen width Ratio as per the UI/UX
  static double uiWidthpx = 375;
  static double scaleWidth = 1;

  static double bodyPadding = 16;
  static double dimen_1 = 1;
  static double dimen_2 = 2;
  static double dimen_3 = 3;
  static double dimen_4 = 4;
  static double dimen_5 = 5;
  static double dimen_6 = 6;
  static double dimen_7 = 7;
  static double dimen_8 = 8;
  static double dimen_9 = 9;
  static double dimen_10 = 10;
  static double dimen_11 = 11;
  static double dimen_12 = 12;
  static double dimen_13 = 13;
  static double dimen_14 = 14;
  static double dimen_15 = 15;
  static double dimen_16 = 16;
  static double dimen_17 = 17;
  static double dimen_18 = 18;
  static double dimen_19 = 19;
  static double dimen_20 = 20;
  static double dimen_22 = 22;
  static double dimen_24 = 24;
  static double dimen_25 = 25;
  static double dimen_27 = 27;
  static double dimen_26 = 26;
  static double dimen_28 = 28;
  static double dimen_30 = 30;
  static double dimen_32 = 32;
  static double dimen_35 = 35;
  static double dimen_36 = 36;
  static double dimen_40 = 40;
  static double dimen_41 = 41;
  static double dimen_45 = 45;
  static double dimen_48 = 48;
  static double dimen_50 = 50;
  static double dimen_55 = 55;
  static double dimen_56 = 56;
  static double dimen_57 = 57;
  static double dimen_60 = 60;
  static double dimen_62 = 62;
  static double dimen_64 = 64;
  static double dimen_66 = 66;
  static double dimen_70 = 70;
  static double dimen_72 = 72;
  static double dimen_75 = 75;
  static double dimen_80 = 80;
  static double dimen_85 = 85;
  static double dimen_90 = 90;
  static double dimen_100 = 100;
  static double dimen_110 = 110;
  static double dimen_115 = 115;
  static double dimen_120 = 120;
  static double dimen_128 = 128;
  static double dimen_130 = 130;
  static double dimen_135 = 135;
  static double dimen_140 = 140;
  static double dimen_145 = 145;
  static double dimen_150 = 150;
  static double dimen_155 = 155;
  static double dimen_160 = 160;
  static double dimen_168 = 168;
  static double dimen_170 = 170;
  static double dimen_180 = 180;
  static double dimen_190 = 190;
  static double dimen_200 = 200;
  static double dimen_220 = 220;
  static double dimen_230 = 230;
  static double dimen_240 = 240;

  static double dimen_245 = 245;

  static double dimen_250 = 250;

  static double dimen_280 = 280;
  static double dimen_300 = 300;
  static double dimen_320 = 320;
  static double dimen_350 = 350;

  static double captionSize = 12;
  static double subtitle1Size = 13;

  static double bodyText1Size = 17;
  static double bodyText2Size = 15;

  static double headline1Size = 28;
  static double headline2Size = 23;
  static double headline3Size = 22;
  static double headline4Size = 17;
  static double headline5Size = 15;
  static double headline6Size = 12;
  static double headline7Size = 11;
  static double headline8Size = 14;

  static double mainHeadLineSize = 20;

  static double inputLabelSize = 13;
  static double buttonTextSize = 13;
  static double cardBorderRadius = dimen_6;

  static const double buttonHeight = 45;
  static BorderRadius buttonBorderRadius = BorderRadius.circular(6);

  static double safeAreaSpace = 0;
  static double labelStyleTextHeight = 0.5;
  static initSetSize(BuildContext context) async {
    /*  final double screenWidth = MediaQueryData.fromWindow(window).size.width;
    if (screenWidth != 0) {
      scaleWidth = screenWidth / uiWidthpx;

      headline1Size = headline1Size * scaleWidth;
      headline2Size = headline2Size * scaleWidth;
      headline3Size = headline3Size * scaleWidth;
      headline4Size = headline4Size * scaleWidth;
      headline5Size = headline5Size * scaleWidth;
      headline6Size = headline6Size * scaleWidth;
      headline7Size = headline7Size * scaleWidth;
      headline8Size = headline8Size * scaleWidth;

      bodyText1Size = bodyText1Size * scaleWidth;
      bodyText2Size = bodyText2Size * scaleWidth;

      captionSize = captionSize * scaleWidth;
      subtitle1Size = subtitle1Size * scaleWidth;

      inputLabelSize = inputLabelSize * scaleWidth;
      buttonTextSize = buttonTextSize * scaleWidth;

      bodyPadding = bodyPadding * scaleWidth;
      dimen_1 = 1 * scaleWidth;
      dimen_2 = 2 * scaleWidth;
      dimen_3 = 3 * scaleWidth;
      dimen_4 = 4 * scaleWidth;
      dimen_5 = 5 * scaleWidth;
      dimen_6 = 6 * scaleWidth;
      dimen_7 = 7 * scaleWidth;
      dimen_8 = 8 * scaleWidth;
      dimen_9 = 9 * scaleWidth;
      dimen_10 = 10 * scaleWidth;
      dimen_11 = 11 * scaleWidth;
      dimen_12 = 12 * scaleWidth;
      dimen_13 = 13 * scaleWidth;
      dimen_14 = 14 * scaleWidth;
      dimen_15 = 15 * scaleWidth;
      dimen_16 = 16 * scaleWidth;
      dimen_17 = 17 * scaleWidth;
      dimen_18 = 18 * scaleWidth;
      dimen_19 = 19 * scaleWidth;
      dimen_20 = 20 * scaleWidth;
      dimen_24 = 24 * scaleWidth;
      dimen_25 = 25 * scaleWidth;
      dimen_27 = 27 * scaleWidth;
      dimen_28 = 28 * scaleWidth;
      dimen_30 = 30 * scaleWidth;
      dimen_32 = 32 * scaleWidth;
      dimen_35 = 35 * scaleWidth;
      dimen_36 = 36 * scaleWidth;
      dimen_40 = 40 * scaleWidth;
      dimen_45 = 45 * scaleWidth;
      dimen_48 = 48 * scaleWidth;
      dimen_50 = 50 * scaleWidth;
      dimen_60 = 60 * scaleWidth;
      dimen_70 = 70 * scaleWidth;
      dimen_80 = 80 * scaleWidth;
      dimen_90 = 90 * scaleWidth;
      dimen_100 = 100 * scaleWidth;
      dimen_110 = 110 * scaleWidth;
      dimen_120 = 120 * scaleWidth;
      dimen_130 = 130 * scaleWidth;
      dimen_140 = 140 * scaleWidth;
      dimen_150 = 150 * scaleWidth;
      dimen_160 = 160 * scaleWidth;
      dimen_170 = 170 * scaleWidth;
      dimen_180 = 180 * scaleWidth;
      dimen_200 = 200 * scaleWidth;
      dimen_230 = 230 * scaleWidth;
      dimen_240 = 240 * scaleWidth;
      dimen_245 = 245 * scaleWidth;
      dimen_250 = 250 * scaleWidth;
      dimen_280 = 280 * scaleWidth;
      dimen_300 = 300 * scaleWidth;
      dimen_320 = 320 * scaleWidth;
      dimen_350 = 350 * scaleWidth;
    } */
  }

  static double getSize(double size) {
    return size * scaleWidth;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding;
  }

  static double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return (screenSize(context).height - safeAreaSpace) / dividedBy;
  }

  static double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  static double fullWidth(BuildContext context) {
    return screenWidth(context, dividedBy: 1);
  }

  static double halfWidth(BuildContext context) {
    return screenWidth(context, dividedBy: 2);
  }

  static double fullHeight(BuildContext context) {
    return screenHeight(context, dividedBy: 1);
  }

  static double halfHeight(BuildContext context) {
    return screenHeight(context, dividedBy: 2);
  }

  static double quaterHeight(BuildContext context) {
    return screenHeight(context, dividedBy: 3);
  }

  static double toolbarHeight() {
    return kToolbarHeight + dimen_16;
  }

  static double indicesHeight() {
    return dimen_140 + dimen_24;
  }

  static double indicesHeightSimilarStocks() {
    return dimen_90 + dimen_6;
  }

  static double indicesWidth() {
    return dimen_140 + dimen_8;
  }

  static double showTransactionHeight(BuildContext context, double size) {
    double sheetSize = size;
    return ((sheetSize / AppWidgetSize.fullHeight(context)) * 100) / 100;
  }

  static bool isDeviceSizeSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 321;
  }
}

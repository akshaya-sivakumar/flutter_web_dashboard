import 'package:flutter/material.dart';
import 'package:flutter_dashboard_web/constants/appwidget_size.dart';
import 'package:flutter_dashboard_web/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppImages {
  static Color getColor(BuildContext context, Color color) {
    return color;
  }

  static SvgPicture getSVGImage(
    String url,
    BuildContext context, {
    Color? color,
    dynamic width,
    dynamic height,
    String? iconName,
    bool isColor = true,
  }) {
    return SvgPicture.asset(
      url,
      // ignore: deprecated_member_use
      color: isColor ? color : null,
      width: width,
      height: height,
      key: Key(iconName ?? ""),
    );
  }

  static nosearchlottie() {
    return Lottie.asset('lib/assets/icons/nosearch.json',
        height: AppWidgetSize.dimen_250);
  }

  static Image watchlistSelected() {
    return const Image(
        image: AssetImage('lib/assets/icons/watchlist_select@3x.png'));
  }

  static Image appIcon() {
    return const Image(image: AssetImage('lib/assets/icons/appIcon.png'));
  }

  static Image storeImg() {
    return Image(
      image: const AssetImage('lib/assets/icons/storepwd.png'),
      height: AppWidgetSize.dimen_60,
      width: AppWidgetSize.dimen_90,
    );
  }

  static Image watchlistSelectedDark() {
    return const Image(
        image: AssetImage('lib/assets/icons/watchlist_select_dark@3x.png'));
  }

  static Image portfolioSelected() {
    return const Image(
        image: AssetImage('lib/assets/icons/portfolio_select@3x.png'));
  }

  static Image portfolioSelectedDark() {
    return const Image(
        image: AssetImage('lib/assets/icons/portfolio_select_dark@3x.png'));
  }

  static Image ordersSelected() {
    return const Image(
        image: AssetImage('lib/assets/icons/orders_select@3x.png'));
  }

  static Image ordersSelectedDark() {
    return const Image(
        image: AssetImage('lib/assets/icons/orders_select_dark@3x.png'));
  }

  static SvgPicture watchlist(BuildContext context,
      {required Color color, double width = 30, double height = 30}) {
    return getSVGImage('lib/assets/icons/watchlist.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture orderbook(BuildContext context,
      {required Color color, double width = 30, double height = 30}) {
    return getSVGImage('lib/assets/icons/orders.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture portfolio(BuildContext context,
      {required Color color, double? width, double? height}) {
    return getSVGImage('lib/assets/icons/portfolio.svg', context,
        color: color, width: width ?? 30, height: height ?? 30);
  }

  static SvgPicture darkThemeIcon(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage(
      'lib/assets/icons/dark_theme.svg',
      context,
      color: color,
      width: width,
      height: height,
    );
  }

  static SvgPicture lightThemeIcon(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage(
      'lib/assets/icons/light_theme.svg',
      context,
      color: color,
      width: width,
      height: height,
    );
  }

  static Image loginIllustration() {
    return Image(
      image: const AssetImage("lib/assets/icons/login_illus.png"),
      width:
          AppWidgetSize.fullWidth(appRoute.navigatorKey.currentContext!) * 0.6,
    );
  }

  static Image inProgress() {
    return const Image(
      image: AssetImage("lib/assets/icons/progress.png"),
    );
  }

  static Image notfoundImage() {
    return const Image(
      image: AssetImage("lib/assets/icons/404page.png"),
      fit: BoxFit.fill,
    );
  }
}

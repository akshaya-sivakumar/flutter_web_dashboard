import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static Color getColor(BuildContext context, Color color) {
    return (color != null) ? color : Theme.of(context).primaryColor;
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
      color: isColor ? color : null,
      width: width,
      height: height,
      key: Key(iconName ?? ""),
    );
  }

  static Image watchlistSelected() {
    return const Image(
        image: AssetImage('lib/assets/icons/watchlist_select@3x.png'));
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

  static const Image LOADER_LIGHT = Image(
    image: AssetImage('lib/assets/icons/loading_white.gif'),
    width: 80,
    height: 80,
  );

  static const Image SEARCH_LOADER = Image(
    image: AssetImage('lib/assets/images/circle_loading.gif'),
    width: 80,
    height: 80,
  );

  static const Image LOADER_DARK = Image(
    image: AssetImage('lib/assets/images/loading_purple.gif'),
    width: 80,
    height: 80,
  );

  static const DecorationImage LAUNCH_BG = DecorationImage(
    image: AssetImage('lib/assets/images/launch_bg.png'),
    fit: BoxFit.fitHeight,
  );

  static const Image patternTop = Image(
    image: AssetImage('lib/assets/images/pattern_top.png'),
    fit: BoxFit.cover,
  );

  static const Image patternBottom = Image(
    image: AssetImage('lib/assets/images/pattern_bottom.png'),
    fit: BoxFit.cover,
  );

  static const Image patternCircleBig = Image(
    image: AssetImage('lib/assets/images/circle_pattern_big@3x.png'),
    fit: BoxFit.cover,
  );

  static const Image patternCircleSmall = Image(
    image: AssetImage('lib/assets/images/circle_pattern_small@3x.png'),
    fit: BoxFit.cover,
  );

  static const Image patternCircleBigForDemat = Image(
    image: AssetImage('lib/assets/images/circle_pattern_big_100@3x.png'),
    fit: BoxFit.cover,
  );

  static const Image patternCircleSmallForDemat = Image(
    image: AssetImage('lib/assets/images/circle_pattern_small_100@3x.png'),
    fit: BoxFit.cover,
  );

  static const Image fingerprintLight = Image(
    image: AssetImage('lib/assets/images/fingerprint_light@2x.png'),
    fit: BoxFit.cover,
  );

  static const Image fundlimitExpand = Image(
    image: AssetImage('lib/assets/images/funds_expand.png'),
    fit: BoxFit.cover,
  );

  static const Image fundlimitCollaspe = Image(
    image: AssetImage('lib/assets/images/funds_unexpand.png'),
    fit: BoxFit.cover,
  );

  static const Image fundlimitExpandDark = Image(
    image: AssetImage('lib/assets/images/funds-expand_dark.png'),
    fit: BoxFit.cover,
  );

  static const Image fundlimitCollaspeDark = Image(
    image: AssetImage('lib/assets/images/funds-unexpand_dark.png'),
    fit: BoxFit.cover,
  );

  static const Image viewChartCoach = Image(
    height: 65,
    image: AssetImage('lib/assets/images/viewchart_coach.png'),
    fit: BoxFit.cover,
  );

/*   static SvgPicture filter(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/filter.svg', context,
        color: color, width: width, height: height, iconName: WATCHLIST_SORT);
  } */

  static SvgPicture search(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/search.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture watchlist(BuildContext context,
      {required Color color, double width = 30, double height = 30}) {
    return getSVGImage('lib/assets/icons/watchlist.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture markets(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/icons/portfolio.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture researchIcon(BuildContext context,
      {required Color color, double width = 10, double height = 10}) {
    return getSVGImage('lib/assets/icons/research.svg', context,
        color: color, width: width, height: height);
  }

  static Image researchSelected() {
    return const Image(
        image: AssetImage('lib/assets/images/research_select@3x.png'));
  }

  static Image researchSelectedDark() {
    return const Image(
        image: AssetImage('lib/assets/images/research_select_dark@3x.png'));
  }

  static Image investSelected() {
    return const Image(
        image: AssetImage('lib/assets/images/invest_select@3x.png'));
  }

  static Image investSelectedDark() {
    return const Image(
        image: AssetImage('lib/assets/images/invest_select_dark@3x.png'));
  }

  static SvgPicture invest(BuildContext context,
      {required Color color, double width = 10, double height = 10}) {
    return getSVGImage('lib/assets/images/invest_menu.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture orderbook(BuildContext context,
      {required Color color, double width = 30, double height = 30}) {
    return getSVGImage('lib/assets/icons/orders.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture you(BuildContext context,
      {required Color color, double width = 10, double height = 10}) {
    return getSVGImage('lib/assets/images/you.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture portfolio(BuildContext context,
      {required Color color, double? width, double? height}) {
    return getSVGImage('lib/assets/icons/portfolio.svg', context,
        color: color, width: width ?? 30, height: height ?? 30);
  }

  static SvgPicture splashlogo(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/splash_logo.svg', context,
        color: color, width: width, height: height);
  }

  /*static SvgPicture splashLogoNew(BuildContext context,
      {Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/splash_logo_new.svg', context,
        color: color, width: width, height: height);
  }*/

  static SvgPicture loginLogoNew(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/splash_logo_new.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture loginlogo(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/login_logo.svg', context,
        color: color, width: width, height: height, iconName: "login_logo");
  }

  static SvgPicture login(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/login.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture menuIcon(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/menu.svg', context,
        color: color, width: width, height: height);
  }

  static SvgPicture messageSquare(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage(
      'lib/assets/images/notification.svg', context,
      color: color, width: width, height: height,
      //  isColor: false
    );
  }

  static SvgPicture editWatchlist(BuildContext context,
      {required Color color, double? width, double? height}) {
    return getSVGImage('lib/assets/images/edit_watchlist.svg', context,
        color: color, width: width ?? 20, height: height ?? 20);
  }

  /*static SvgPicture semiCircle(BuildContext context,
      {Color color, double width, double height}) {
    return getSVGImage('lib/assets/images/semi_circle.svg', context,
        color: color, width: width, height: height, iconName: SEMI_CIRCLE);
  }*/

  static SvgPicture buy_btn(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/buy_btn.svg', context,
        isColor: false, color: color, width: width, height: height);
  }

  static SvgPicture sell_btn(BuildContext context,
      {required Color color, required double width, required double height}) {
    return getSVGImage('lib/assets/images/sell_btn.svg', context,
        isColor: false, color: color, width: width, height: height);
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

  static Image lineActive() {
    return const Image(
        image: AssetImage('lib/assets/images/line_active@3x.png'));
  }

  static Image lineInActive() {
    return const Image(
        image: AssetImage('lib/assets/images/line_unactive@3x.png'));
  }

  static Image barActive() {
    return const Image(
        image: AssetImage('lib/assets/images/bar_active@3x.png'));
  }

  static Image barInActive() {
    return const Image(
        image: AssetImage('lib/assets/images/bar_unactive@3x.png'));
  }

  static Image candleActive() {
    return const Image(
        image: AssetImage('lib/assets/images/candle_active@3x.png'));
  }

  static Image candleInActive() {
    return const Image(
        image: AssetImage('lib/assets/images/candle_unactive@3x.png'));
  }

  static Image mountainActive() {
    return const Image(
        image: AssetImage('lib/assets/images/mountain_active@3x.png'));
  }

  static Image mountainInActive() {
    return const Image(
        image: AssetImage('lib/assets/images/mountain_unactive@3x.png'));
  }

  static Image fingerprintLight3x() {
    return const Image(
        image: AssetImage('lib/assets/images/fingerprint_light@3x.png'));
  }

  static Image fingerprintDark3x() {
    return const Image(
        image: AssetImage('lib/assets/images/fingerprint_dark@3x.png'));
  }

  static Image android() {
    return const Image(image: AssetImage('lib/assets/images/android@3x.png'));
  }

  static Image ios() {
    return const Image(image: AssetImage('lib/assets/images/iphone@3x.png'));
  }

  static Image emptyPortfolio() {
    return const Image(
        image: AssetImage('lib/assets/images/empty_portfolio.png'));
  }

  static Image technicalIssuePortfolioDark() {
    return const Image(
        image: AssetImage('lib/assets/images/technical_issue_dark@2x.png'));
  }

  static Image technicalIssuePortfolioLight() {
    return const Image(
        image: AssetImage('lib/assets/images/technical_issue_light@2x.png'));
  }

  static Image emptyPortfolioDark() {
    return const Image(
        image: AssetImage('lib/assets/images/empty_portfolio_dark@2x.png'));
  }
}

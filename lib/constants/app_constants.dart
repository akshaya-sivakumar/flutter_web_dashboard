import 'package:flutter/material.dart';

import '../utils/app_utils.dart';

class AppConstants {
  static const String enterMobileNo = "Enter the Mobile Number to Login";

  static const String phNo = "Phone Number";

  static const String otpVerify = "Please enter the OTP to Login";
  static const String otpVerified = "A OTP has been sent to ";
  static const String resendOtp = "Resend OTP";
  static const String pleaseWait = "Please wait...";

  static const String sell = "SELL";
  static const String buy = "BUY";
  static const String name = "Name";
  static const String detail = "Details";

  static const String mobileValidation = "Please enter valid mobile number";

  static const String pageNotfound = "Page Not Found";
  static const String isDark = "isDark";
  static const String welcometext = "Welcome! Let's get started !!!";

  static const String loginCap = "LOGIN";
  static const String login = "Login";
  static const String mobilenumber = "Mobile Number";
  static const String atoz = 'A - Z';
  static const String ztoa = 'Z - A';
  static const String nifty50 = "NIFTY 50";
  static const String sensex = "SENSEX";
  static const String niftyvalue = "14,696.50";
  static const String niftyPer = " (1.04%)";
  static const String sensexvalue = "48,690.80";
  static const String sensexPer = " (0.96%)";
  static const String myList = "My List";
  static const String details = "Details";
  static const String unknownError = "Unknown Error";
  static const String watchlist = "Watchlist";
  static const String orders = "Orders";
  static const String portfolio = "Portfolio";
  static const String logout = "Logout";
  static const String logoutCap = "LOGOUT";
  static const String confirmLogout = "Confirm Logout !!!";
  static const String logoutStatement = "Are you sure you want to logout?";
  static const String cancel = "CANCEL";
  static const String appId = "f79f65f1b98e116f40633dbb46fd5e21";
  static const String appIdOtp = "45370504ab27eed7327a1df46403a30a";
  static const String usertype = "virtual";
  static const String validateOtp = "Validate OTP";
  static const String validity = "Validity";
  static const String day = "DAY";
  static const String ioc = "IOC";
  static const String gtc = "GTC";
  static const String qty = "Quantity";
  static const String price = 'Price';
  static const String disclosedQty = 'Disclosed qty';
  static const String stoplossTrigger = 'Stoploss Trigger Price';
  static const String pdgTypestatement =
      "Pay fill and get shares in your DP Account";
  static const String buySmall = 'Buy';
  static const String sellSmall = 'Sell';
  static const String product = 'Product';
  static const String notfounstatement = "OOPS!!\n Nothing here... ";
  static const String enterHere = 'Enter here';
  static const String sessionExpired = "Session Expired.Please Login again";

  static const String webPosition = "right";
  static const String webBgColor =
      "linear-gradient(to right, #F8313E, #F8313E)";
  static List quoteTablist = [
    "Overview",
    "Technicals",
    "Futures",
    "Options",
    "News"
  ];

  static List<String> myListData = [
    "My List1",
    "My List2",
    "My List3",
    "My List4",
  ];

  static const String fontName = 'opensans';

  static const String darkMode = 'Dark Mode';

  Color light = const Color(0xFFF7F8FC);
  Color lightGrey = const Color(0xFFA4A6B3);
  Color dark = const Color(0xFF363740);
  Color active = const Color(0xFF3C19C0);

  static const String loginKey = "login";
  static const String watchlistKey = 'watchlistresponse';
  static const String encryptKey = "flutterwebsample";
  String weburl =
      "https://www.tradingview.com/widgetembed/?frameElementId=tradingview_9c2ce&symbol=NASDAQ%3AAAPL&interval=D&hidesidetoolbar=1&symboledit=0&saveimage=1&toolbarbg=f1f3f6&studies=%5B%5D&theme=${AppUtils.isDarktheme ? "dark" : "light"}&style=1&timezone=Etc%2FUTC&studies_overrides=%7B%7D&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&utm_source=www.tradingview.com&utm_medium=widget_new&utm_campaign=chart&utm_term=NASDAQ%3AAAPL";
}

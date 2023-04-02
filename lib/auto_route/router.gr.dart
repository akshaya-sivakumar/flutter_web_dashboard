// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_dashboard_web/ui/screens/dashboard.dart' as _i2;
import 'package:flutter_dashboard_web/ui/screens/not_found.dart' as _i1;
import 'package:flutter_dashboard_web/ui/screens/otp_screen.dart' as _i4;
import 'package:flutter_dashboard_web/ui/screens/registration.dart' as _i3;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    Notfound.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.NotFoundScreen(),
      );
    },
    Dashboard.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardScreen(),
      );
    },
    Registration.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WrappedRoute(child: const _i3.RegistrationScreen()),
      );
    },
    Otpvalidation.name: (routeData) {
      final args = routeData.argsAs<OtpvalidationArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.OtpValidationscreen(
          key: args.key,
          mobileNumber: args.mobileNumber,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.NotFoundScreen]
class Notfound extends _i5.PageRouteInfo<void> {
  const Notfound({List<_i5.PageRouteInfo>? children})
      : super(
          Notfound.name,
          initialChildren: children,
        );

  static const String name = 'Notfound';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DashboardScreen]
class Dashboard extends _i5.PageRouteInfo<void> {
  const Dashboard({List<_i5.PageRouteInfo>? children})
      : super(
          Dashboard.name,
          initialChildren: children,
        );

  static const String name = 'Dashboard';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RegistrationScreen]
class Registration extends _i5.PageRouteInfo<void> {
  const Registration({List<_i5.PageRouteInfo>? children})
      : super(
          Registration.name,
          initialChildren: children,
        );

  static const String name = 'Registration';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OtpValidationscreen]
class Otpvalidation extends _i5.PageRouteInfo<OtpvalidationArgs> {
  Otpvalidation({
    _i6.Key? key,
    required String mobileNumber,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          Otpvalidation.name,
          args: OtpvalidationArgs(
            key: key,
            mobileNumber: mobileNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'Otpvalidation';

  static const _i5.PageInfo<OtpvalidationArgs> page =
      _i5.PageInfo<OtpvalidationArgs>(name);
}

class OtpvalidationArgs {
  const OtpvalidationArgs({
    this.key,
    required this.mobileNumber,
  });

  final _i6.Key? key;

  final String mobileNumber;

  @override
  String toString() {
    return 'OtpvalidationArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}

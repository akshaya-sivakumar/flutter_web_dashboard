// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:flutter_dashboard_web/ui/screens/dashboard/widgets/dashboard.dart'
    deferred as _i2;
import 'package:flutter_dashboard_web/ui/screens/pageNotfound/not_found.dart'
    deferred as _i1;
import 'package:flutter_dashboard_web/ui/screens/login/registration.dart'
    deferred as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    Notfound.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i1.loadLibrary,
          () => _i1.NotFoundScreen(),
        ),
      );
    },
    Dashboard.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.DashboardScreen(),
        ),
      );
    },
    Registration.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DeferredWidget(
          _i3.loadLibrary,
          () => _i4.WrappedRoute(child: _i3.RegistrationScreen()),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.NotFoundScreen]
class Notfound extends _i4.PageRouteInfo<void> {
  const Notfound({List<_i4.PageRouteInfo>? children})
      : super(
          Notfound.name,
          initialChildren: children,
        );

  static const String name = 'Notfound';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DashboardScreen]
class Dashboard extends _i4.PageRouteInfo<void> {
  const Dashboard({List<_i4.PageRouteInfo>? children})
      : super(
          Dashboard.name,
          initialChildren: children,
        );

  static const String name = 'Dashboard';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RegistrationScreen]
class Registration extends _i4.PageRouteInfo<void> {
  const Registration({List<_i4.PageRouteInfo>? children})
      : super(
          Registration.name,
          initialChildren: children,
        );

  static const String name = 'Registration';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

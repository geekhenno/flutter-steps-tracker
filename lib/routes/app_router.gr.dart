// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../features/authentication/presentation/screens/user_login_screen.dart'
    as _i2;
import '../features/bottom_navigation/presentation/screens/bottom_navigation_screen.dart'
    as _i3;
import '../features/dashboard/presentation/screens/dashboard_screen.dart'
    as _i6;
import '../features/redeeming/domain/entities/redeeming_entity.dart' as _i10;
import '../features/redeeming/presentation/screens/redeem_history.dart' as _i5;
import '../features/redeeming/presentation/screens/redeeming_details_screen.dart'
    as _i4;
import '../features/redeeming/presentation/screens/redeeming_screen.dart'
    as _i7;
import '../features/splash/presentation/screens/splash_screen.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    UserLoginRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.UserLoginScreen(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    },
    BottomNavigationRoute.name: (routeData) {
      return _i8.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.BottomNavigationScreen(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    },
    RedeemingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RedeemingDetailsRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.RedeemingDetailsScreen(key: args.key, item: args.item));
    },
    RedeemHistoryRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.RedeemHistoryScreen());
    },
    DashboardRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.DashboardScreen());
    },
    RedeemingRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.RedeemingScreen());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(SplashRoute.name, path: '/'),
        _i8.RouteConfig(UserLoginRoute.name, path: '/user-login-screen'),
        _i8.RouteConfig(BottomNavigationRoute.name,
            path: '/bottom-navigation-screen',
            children: [
              _i8.RouteConfig(DashboardRoute.name,
                  path: 'dashboard-screen', parent: BottomNavigationRoute.name),
              _i8.RouteConfig(RedeemingRoute.name,
                  path: 'redeeming-screen', parent: BottomNavigationRoute.name)
            ]),
        _i8.RouteConfig(RedeemingDetailsRoute.name,
            path: '/redeeming-details-screen'),
        _i8.RouteConfig(RedeemHistoryRoute.name, path: '/redeem-history-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.UserLoginScreen]
class UserLoginRoute extends _i8.PageRouteInfo<void> {
  const UserLoginRoute()
      : super(UserLoginRoute.name, path: '/user-login-screen');

  static const String name = 'UserLoginRoute';
}

/// generated route for
/// [_i3.BottomNavigationScreen]
class BottomNavigationRoute extends _i8.PageRouteInfo<void> {
  const BottomNavigationRoute({List<_i8.PageRouteInfo>? children})
      : super(BottomNavigationRoute.name,
            path: '/bottom-navigation-screen', initialChildren: children);

  static const String name = 'BottomNavigationRoute';
}

/// generated route for
/// [_i4.RedeemingDetailsScreen]
class RedeemingDetailsRoute
    extends _i8.PageRouteInfo<RedeemingDetailsRouteArgs> {
  RedeemingDetailsRoute({_i9.Key? key, required _i10.RedeemingEntity item})
      : super(RedeemingDetailsRoute.name,
            path: '/redeeming-details-screen',
            args: RedeemingDetailsRouteArgs(key: key, item: item));

  static const String name = 'RedeemingDetailsRoute';
}

class RedeemingDetailsRouteArgs {
  const RedeemingDetailsRouteArgs({this.key, required this.item});

  final _i9.Key? key;

  final _i10.RedeemingEntity item;

  @override
  String toString() {
    return 'RedeemingDetailsRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i5.RedeemHistoryScreen]
class RedeemHistoryRoute extends _i8.PageRouteInfo<void> {
  const RedeemHistoryRoute()
      : super(RedeemHistoryRoute.name, path: '/redeem-history-screen');

  static const String name = 'RedeemHistoryRoute';
}

/// generated route for
/// [_i6.DashboardScreen]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: 'dashboard-screen');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i7.RedeemingScreen]
class RedeemingRoute extends _i8.PageRouteInfo<void> {
  const RedeemingRoute() : super(RedeemingRoute.name, path: 'redeeming-screen');

  static const String name = 'RedeemingRoute';
}

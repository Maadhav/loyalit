// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../view/auth/auth_view.dart' as _i3;
import '../view/auth/sign_in_view.dart' as _i2;
import '../view/home/home_view.dart' as _i1;
import '../view/nft_detail/nft_detail_view.dart' as _i4;
import 'app_router.dart' as _i7;
import 'model/coupon.dart' as _i8;

class AppRouter extends _i5.RootStackRouter {
  AppRouter({
    _i6.GlobalKey<_i6.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i7.AuthGuard authGuard;

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInView(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthView(),
      );
    },
    NFTDetailRoute.name: (routeData) {
      final args = routeData.argsAs<NFTDetailRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.NFTDetailView(
          key: args.key,
          coupon: args.coupon,
        ),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/',
          guards: [authGuard],
        ),
        _i5.RouteConfig(
          SignInRoute.name,
          path: '/sign-in',
        ),
        _i5.RouteConfig(
          AuthRoute.name,
          path: 'auth',
        ),
        _i5.RouteConfig(
          NFTDetailRoute.name,
          path: '/nft',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.SignInView]
class SignInRoute extends _i5.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.AuthView]
class AuthRoute extends _i5.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: 'auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i4.NFTDetailView]
class NFTDetailRoute extends _i5.PageRouteInfo<NFTDetailRouteArgs> {
  NFTDetailRoute({
    _i6.Key? key,
    required _i8.Coupon coupon,
  }) : super(
          NFTDetailRoute.name,
          path: '/nft',
          args: NFTDetailRouteArgs(
            key: key,
            coupon: coupon,
          ),
        );

  static const String name = 'NFTDetailRoute';
}

class NFTDetailRouteArgs {
  const NFTDetailRouteArgs({
    this.key,
    required this.coupon,
  });

  final _i6.Key? key;

  final _i8.Coupon coupon;

  @override
  String toString() {
    return 'NFTDetailRouteArgs{key: $key, coupon: $coupon}';
  }
}

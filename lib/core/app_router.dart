import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:loyalit/core/app_router.gr.dart';
import 'package:loyalit/core/service/auth_service.dart';
import 'package:loyalit/view/auth/auth_view.dart';
import 'package:loyalit/view/auth/sign_in_view.dart';
import 'package:loyalit/view/home/home_view.dart';
import 'package:loyalit/view/nft_detail/nft_detail_view.dart';

import 'app_locator.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(
      initial: true,
      path: '/',
      page: HomeView,
      guards: [AuthGuard],
    ),
    AutoRoute(
      path: '/sign-in',
      page: SignInView,
    ),
    AutoRoute(
      path: 'auth',
      page: AuthView,
    ),
    AutoRoute(
      path: '/nft',
      page: NFTDetailView,
    ),
  ],
)
class $AppRouter {}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await locator<AuthService>().checkAuthStatus()) {
      log("AuthGuard: Authenticated");
      resolver.next(true);
    } else {
      log("AuthGuard: Not Authenticated");
      await router.push(const SignInRoute());
      if (await locator<AuthService>().checkAuthStatus()) {
        resolver.next(true);
      }
    }
  }
}

import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:loyality_craft/core/app_router.gr.dart';
import 'package:loyality_craft/core/service/auth_service.dart';
import 'package:loyality_craft/view/auth/auth_view.dart';
import 'package:loyality_craft/view/auth/sign_in_view.dart';
import 'package:loyality_craft/view/home/home_view.dart';

import 'app_locator.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    // AutoRoute<dynamic>(
    //   initial: true,
    //   path: '/',
    //   page: HomeView,
    // ),
    AutoRoute(
      path: '/',
      initial: true,
      page: SignInView,
    ),
    AutoRoute(
      path: 'auth',
      page: AuthView,
    ),
  ],
)
class $AppRouter {}

// class AuthGuard extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) async {
//     if (await locator<AuthService>().checkAuthStatus()) {
//       log("AuthGuard: Authenticated");
//       resolver.next(true);
//     } else {
//       log("AuthGuard: Not Authenticated");
//       await router.push(const SignInRoute());
//       if (await locator<AuthService>().checkAuthStatus()) {
//         resolver.next(true);
//       }
//     }
//   }
// }

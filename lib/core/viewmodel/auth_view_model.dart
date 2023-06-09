import 'dart:developer';

import 'package:loyalit/core/app_router.gr.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../app_locator.dart';
import '../service/auth_service.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _router = locator<AppRouter>();
  WebViewController controller = WebViewController();

  final authUri = Uri.parse('https://loyalit.onrender.com/auth/google');

  void init() {
    controller = WebViewController()
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36')
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onNavigationRequest: checkWebViewPage),
      )
      ..loadRequest(authUri);
  }

  Future<NavigationDecision> checkWebViewPage(NavigationRequest request) async {
    if (request.url.startsWith('loyalitycraft://login')) {
      Uri uri = Uri.parse(request.url);
      String? accessToken = uri.queryParameters['accessToken'];
      String? idToken = uri.queryParameters['idToken'];
      String? error = uri.queryParameters['error'];
      if (accessToken != null && idToken != null) {
        // perform some action like navigating to the next page
        await _authService.signInWithAccessToken(
            accessToken: accessToken, idToken: idToken);
        if (await _authService.checkAuthStatus()) {
          log('User is signed in!');
          _router.replaceAll([const HomeRoute()]);
        }
      } else if (error != null) {
        log(error);
      }
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void navigateToAuth() {
    _router.push(const AuthRoute());
  }
}

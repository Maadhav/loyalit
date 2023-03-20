import 'package:loyality_craft/core/app_locator.dart';
import 'package:loyality_craft/core/service/auth_service.dart';
import 'package:loyality_craft/core/viewmodel/base_view_model.dart';

import '../app_router.gr.dart';

class HomeViewModel extends BaseViewModel {
  final _router = locator.get<AppRouter>();

  String _email = '';

  String get email => _email;

  int _index = 0;

  int get index => _index;

  init() {
    _email = locator.get<AuthService>().getUser().email ?? '';
  }

  void changeIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void signOut() {
    locator.get<AuthService>().signOut();
    _router.replace(const SignInRoute());
  }
}

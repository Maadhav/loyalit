import 'package:loyalit/core/app_locator.dart';
import 'package:loyalit/core/model/coupon.dart';
import 'package:loyalit/core/service/auth_service.dart';
import 'package:loyalit/core/service/firestore_service.dart';
import 'package:loyalit/core/viewmodel/base_view_model.dart';

import '../app_router.gr.dart';

class HomeViewModel extends BaseViewModel {
  final _router = locator.get<AppRouter>();

  String _email = '';
  String get email => _email;

  Coupon? _coupon;
  Coupon? get coupon => _coupon;

  init() {
    _email = locator.get<AuthService>().getUser().email ?? '';
    getCoupon();
  }

  Future<void> getCoupon() async {
    _coupon = await locator<FirestoreService>().getCoupon(email);
    notifyListeners();
  }

  void signOut() {
    locator.get<AuthService>().signOut();
    _router.replace(const SignInRoute());
  }
}

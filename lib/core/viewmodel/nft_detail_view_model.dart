import 'package:loyalit/core/app_locator.dart';
import 'package:loyalit/core/model/coupon.dart';
import 'package:loyalit/core/service/auth_service.dart';
import 'package:loyalit/core/viewmodel/base_view_model.dart';

class NFTDetailViewModel extends BaseViewModel {
  late final Coupon _coupon;
  Coupon get coupon => _coupon;

  String _email = '';
  String get email => _email;

  int _index = 0;
  int get index => _index;

  init({required Coupon coupon}) {
    setStatus(ViewStatus.busy);
    _coupon = coupon;
    _email = locator.get<AuthService>().getUser().email ?? '';
    setStatus(ViewStatus.ready);
    notifyListeners();
  }

  void changeIndex(int index) {
    _index = index;
    notifyListeners();
  }
}

import 'package:get_it/get_it.dart';
import 'package:loyalit/core/service/auth_service.dart';
import 'package:loyalit/core/service/firestore_service.dart';
import 'package:loyalit/core/service/shared_pref_service.dart';

import 'app_router.dart';
import 'app_router.gr.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<AppRouter>(AppRouter(authGuard: AuthGuard()));
  locator.registerSingleton<SharedPrefService>(SharedPrefService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<FirestoreService>(FirestoreService());
}

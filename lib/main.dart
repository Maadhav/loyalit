import 'dart:async';

import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loyalit/core/app_locator.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/app_provider.dart';
import 'core/app_router.gr.dart';
import 'core/app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FkUserAgent.init();
  await setupLocator();

  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = locator<AppRouter>();
    return AppProvider(
      child: ScreenUtilInit(
          designSize: const Size(430, 932),
          builder: (context, _) {
            return MaterialApp.router(
              title: 'Loyality Craft',
              debugShowCheckedModeBanner: false,
              routerDelegate: appRouter.delegate(),
              routeInformationParser: appRouter.defaultRouteParser(),
              theme: ThemeData(
                fontFamily: 'Poppins',
              ),
            );
          }),
    );
  }
}

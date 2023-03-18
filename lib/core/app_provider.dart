import 'package:flutter/material.dart';
import 'package:loyality_craft/core/viewmodel/auth_view_model.dart';
import 'package:loyality_craft/core/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

///[AppProvider] returns a [MultiProvider] widget that can be used to
///wrap a widget to provide the state through a dependency injection to
///all the child widgets. We wrap the [MaterialApp] with widget to provide
///the state from view models in the whole app.
class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
      ],
      child: child,
    );
  }
}

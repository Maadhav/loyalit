import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodel/auth_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Center(child: Text('You are not currently signed in.')),
          ElevatedButton(
            onPressed: context.watch<AuthViewModel>().navigateToAuth,
            child: const Text('SIGN IN'),
          ),
        ],
      ),
    );
  }
}

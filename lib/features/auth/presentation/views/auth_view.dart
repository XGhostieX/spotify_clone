import 'package:flutter/material.dart';

import 'widgets/sign_up.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignUp());
  }
}

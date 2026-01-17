import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'custom_field.dart';
import 'gradient_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15).copyWith(top: MediaQuery.sizeOf(context).height / 4),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign In.', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            CustomField(
              controller: emailController,
              hint: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            CustomField(
              controller: passwordController,
              hint: 'Password',
              isObscure: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            GradientButton(title: 'Sign In', onpress: () => formKey.currentState!.validate()),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  const TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(color: AppColors.gradient2, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

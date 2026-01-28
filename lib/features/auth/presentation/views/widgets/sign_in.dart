import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../views_model/auth_view_model.dart';
import 'custom_field.dart';
import 'gradient_button.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
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
    bool isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    return Scaffold(
      body: SingleChildScrollView(
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
              GradientButton(
                title: isLoading ? '' : 'Sign In',
                onpress: () async {
                  if (formKey.currentState!.validate()) {
                    final signIn = await ref
                        .read(authViewModelProvider.notifier)
                        .signin(email: emailController.text, password: passwordController.text);
                    if (signIn) {
                      GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: const TextStyle(
                        color: AppColors.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => GoRouter.of(context).pushReplacement(AppRouter.kSignUp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/auth_view.dart';
import '../../features/auth/presentation/views/widgets/sign_in.dart';
import '../../features/auth/presentation/views/widgets/sign_up.dart';

abstract class AppRouter {
  // static const kAuthView = '/auth';
  static const kSignIn = '/signin';
  static const kSignUp = '/signup';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AuthView()),
      GoRoute(path: kSignIn, builder: (context, state) => const SignIn()),
      GoRoute(path: kSignUp, builder: (context, state) => const SignUp()),
    ],
  );
}

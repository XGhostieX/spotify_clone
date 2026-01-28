import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/auth_view.dart';
import '../../features/auth/presentation/views/widgets/sign_in.dart';
import '../../features/auth/presentation/views/widgets/sign_up.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../providers/user_notifier.dart';

abstract class AppRouter {
  // static const kAuthView = '/auth';
  static const kSignIn = '/signin';
  static const kSignUp = '/signup';
  static const kHomeView = '/home';

  static GoRouter router(WidgetRef ref) => GoRouter(
    redirect: (context, state) {
      final user = ref.read(userNotifierProvider);
      if (user != null) {
        return kHomeView;
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AuthView()),
      GoRoute(path: kSignIn, builder: (context, state) => const SignIn()),
      GoRoute(path: kSignUp, builder: (context, state) => const SignUp()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}

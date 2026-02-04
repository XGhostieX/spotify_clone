import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/sign_in_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/home/presentation/views/nav_view.dart';
import '../../features/home/presentation/views/upload_song_view.dart';
import '../providers/user_notifier.dart';

abstract class AppRouter {
  static const kSignInView = '/signin';
  static const kSignUpView = '/signup';
  static const kNavView = '/nav';
  static const kHomeView = '/home';
  static const kUploadSongView = '/uplaod-song';

  static GoRouter router(WidgetRef ref) => GoRouter(
    redirect: (context, state) {
      final user = ref.read(userNotifierProvider);
      if (user != null) {
        return kNavView;
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SignInView()),
      GoRoute(path: kSignInView, builder: (context, state) => const SignInView()),
      GoRoute(path: kSignUpView, builder: (context, state) => const SignUpView()),
      GoRoute(path: kNavView, builder: (context, state) => const NavView()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(path: kUploadSongView, builder: (context, state) => const UploadSongView()),
    ],
  );
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../auth/presentation/views_model/auth_view_model.dart';
import 'widgets/library_view_body.dart';

class LibraryView extends ConsumerWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Libaray', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
        backgroundColor: AppColors.transparentColor,
        actions: [
          IconButton(
            onPressed: () => AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.scale,
              title: 'Sign Out',
              desc: 'Do you Want to Sign Out ?',
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                ref.read(authViewModelProvider.notifier).signout();
                GoRouter.of(context).pushReplacement(AppRouter.kSignInView);
              },
            ).show(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const LibraryViewBody(),
    );
  }
}

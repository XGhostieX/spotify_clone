import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/song_notifier.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/functions/color_switch.dart';
import 'widgets/music_player_view_body.dart';

class MusicPlayerView extends ConsumerWidget {
  const MusicPlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(songNotifierProvider)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [hexToColor(song.color), const Color(0xFF121212)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        appBar: AppBar(
          backgroundColor: AppColors.transparentColor,
          leading: Transform.translate(
            offset: const Offset(10, 0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: Image.asset(Assets.pullDownArrow),
            ),
          ),
        ),
        body: const MusicPlayerViewBody(),
      ),
    );
  }
}

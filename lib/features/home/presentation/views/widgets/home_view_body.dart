import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/song_notifier.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/functions/color_switch.dart';
import 'latest_songs_listview.dart';
import 'recent_songs_gridview.dart';

class HomeViewBody extends ConsumerWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(songNotifierProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: song == null
            ? null
            : BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [hexToColor(song.color), AppColors.transparentColor],
                  stops: [0.0, 0.3],
                ),
              ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecentSongsGridview(),
            Text('Latest Songs', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
            LatestSongsListview(),
          ],
        ),
      ),
    );
  }
}

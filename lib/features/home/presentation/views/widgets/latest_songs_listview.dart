import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../views_model/home_view_model.dart';
import 'latest_songs_item.dart';

class LatestSongsListview extends ConsumerWidget {
  const LatestSongsListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(fetchSongsProvider)
        .when(
          data: (songs) => SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => LatestSongsItem(song: songs[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: songs.length,
            ),
          ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => Center(
            child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.gradient2, size: 200),
          ),
        );
  }
}

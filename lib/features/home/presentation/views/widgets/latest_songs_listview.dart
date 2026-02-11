import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/providers/song_notifier.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../views_model/home_view_model.dart';
import 'latest_songs_item.dart';

class LatestSongsListview extends ConsumerWidget {
  const LatestSongsListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(fetchRemoteSongsProvider)
        .when(
          data: (songs) => Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                borderRadius: BorderRadius.circular(7),
                onTap: () => ref.read(songNotifierProvider.notifier).updateSong(songs[index]),
                child: LatestSongsItem(song: songs[index]),
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
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

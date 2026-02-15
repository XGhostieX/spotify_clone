import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/song_model.dart';
import '../../../../../core/providers/song_notifier.dart';
import '../../views_model/home_view_model.dart';
import 'recent_songs_gridview_item.dart';

class RecentSongsGridview extends ConsumerWidget {
  const RecentSongsGridview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<SongModel> songs = ref.watch(homeViewModelProvider.notifier).fetchLocalSongs();
    ref.watch(songNotifierProvider);
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      height: 250,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: songs.length,
        itemBuilder: (context, index) => InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: () => ref.read(songNotifierProvider.notifier).updateSong(songs[index]),
          child: RecentSongsGridviewItem(song: songs[index]),
        ),
      ),
    );
  }
}

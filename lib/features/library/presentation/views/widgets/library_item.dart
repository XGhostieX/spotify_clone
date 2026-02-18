import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/song_model.dart';
import '../../../../../core/providers/song_notifier.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../views_model/library_view_model.dart';

class LibraryItem extends ConsumerWidget {
  final SongModel song;
  const LibraryItem({super.key, required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(song.thumbnail),
        backgroundColor: AppColors.backgroundColor,
        radius: 35,
      ),
      title: Text(song.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      subtitle: Text(
        song.artist,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      trailing: IconButton(
        onPressed: () async =>
            await ref.read(libraryViewModelProvider.notifier).favoriteSong(id: song.id),
        icon: const Icon(CupertinoIcons.heart_fill),
      ),
      onTap: () => ref.read(songNotifierProvider.notifier).updateSong(song),
    );
  }
}

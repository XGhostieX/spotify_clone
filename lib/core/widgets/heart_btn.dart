import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/song_notifier.dart';
import '../providers/user_notifier.dart';
import '../../features/library/presentation/views_model/library_view_model.dart';

class HeartBtn extends ConsumerWidget {
  const HeartBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(userNotifierProvider.select((user) => user!.favorites));
    final song = ref.watch(songNotifierProvider)!;
    return IconButton(
      onPressed: () async =>
          await ref.read(libraryViewModelProvider.notifier).favoriteSong(id: song.id),
      icon: Icon(
        favorites.where((favorite) => favorite.songId == song.id).toList().isEmpty
            ? CupertinoIcons.heart
            : CupertinoIcons.heart_fill,
      ),
    );
  }
}

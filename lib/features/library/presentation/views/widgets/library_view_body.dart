import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/song_notifier.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/functions/color_switch.dart';
import 'library_listview.dart';

class LibraryViewBody extends ConsumerWidget {
  const LibraryViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(songNotifierProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: song == null
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [hexToColor(song.color), AppColors.transparentColor],
                stops: [0.0, 0.35],
              ),
            ),
      child: const LibraryListview(),
    );
  }
}

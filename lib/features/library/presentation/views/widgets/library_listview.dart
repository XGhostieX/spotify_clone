import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../views_model/library_view_model.dart';
import 'library_item.dart';

class LibraryListview extends ConsumerWidget {
  const LibraryListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(fetchFavoriteSongsProvider)
        .when(
          data: (songs) => Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index == songs.length) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.backgroundColor,
                      radius: 35,
                      child: Icon(CupertinoIcons.plus),
                    ),
                    title: const Text(
                      'Upload New Song',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),

                    onTap: () => GoRouter.of(context).push(AppRouter.kUploadSongView),
                  );
                }
                return LibraryItem(song: songs[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: songs.length + 1,
            ),
          ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => Center(
            child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.gradient2, size: 200),
          ),
        );
  }
}

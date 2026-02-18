import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/song_notifier.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/widgets/svg_btn.dart';
import '../../../../../core/widgets/heart_btn.dart';
import 'music_slider.dart';

class MusicPlayerViewBody extends ConsumerWidget {
  const MusicPlayerViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(songNotifierProvider)!;
    final songNotifier = ref.read(songNotifierProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Hero(
              tag: 'thumbnail',
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                    imageUrl: song.thumbnail,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.name,
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          song.artist,
                          style: const TextStyle(
                            color: AppColors.subtitleText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const HeartBtn(),
                  ],
                ),
                const SizedBox(height: 15),
                const MusicSlider(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgBtn(onPress: () {}, asset: Assets.shuffle),
                    SvgBtn(onPress: () {}, asset: Assets.previous),
                    IconButton(
                      onPressed: songNotifier.playPause,
                      icon: Icon(
                        songNotifier.isPlaying()
                            ? CupertinoIcons.pause_circle_fill
                            : CupertinoIcons.play_circle_fill,
                        color: AppColors.whiteColor,
                        size: 80,
                      ),
                    ),
                    SvgBtn(onPress: () {}, asset: Assets.next),
                    SvgBtn(onPress: () {}, asset: Assets.repeat),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgBtn(onPress: () {}, asset: Assets.connectDevice),
                    SvgBtn(onPress: () {}, asset: Assets.playlist),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/song_notifier.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/functions/color_switch.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(songNotifierProvider);
    final songNotifier = ref.read(songNotifierProvider.notifier);
    return song == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Stack(
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.sizeOf(context).width - 27,
                  decoration: BoxDecoration(
                    color: hexToColor(song.color),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CachedNetworkImage(
                              imageUrl: song.thumbnail,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                song.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                song.artist,
                                style: const TextStyle(
                                  color: AppColors.subtitleText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.heart, color: AppColors.whiteColor),
                          ),
                          IconButton(
                            onPressed: () => songNotifier.playPause(),
                            icon: Icon(
                              songNotifier.isPlaying()
                                  ? CupertinoIcons.pause_solid
                                  : CupertinoIcons.play_arrow_solid,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.only(left: 3),
                    height: 2,
                    width: MediaQuery.sizeOf(context).width - 33,
                    decoration: BoxDecoration(
                      color: AppColors.inactiveSeekColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: songNotifier.audioPlayer()?.positionStream,
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }
                    final position = asyncSnapshot.data;
                    final duration = songNotifier.audioPlayer()?.duration;
                    double sliderValue = 0.0;
                    if (position != null && duration != null) {
                      sliderValue = position.inMicroseconds / duration.inMicroseconds;
                    }
                    return Positioned(
                      bottom: 0,
                      child: Container(
                        margin: const EdgeInsets.only(left: 3),
                        height: 2,
                        width: sliderValue * (MediaQuery.sizeOf(context).width - 33),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}

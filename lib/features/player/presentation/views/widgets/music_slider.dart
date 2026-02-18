import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/song_notifier.dart';
import '../../../../../core/theme/app_colors.dart';

class MusicSlider extends ConsumerWidget {
  const MusicSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songNotifier = ref.read(songNotifierProvider.notifier);
    return StreamBuilder(
      stream: songNotifier.audioPlayer()!.positionStream,
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
        return Column(
          children: [
            StatefulBuilder(
              builder: (context, setState) => SliderTheme(
                data: SliderThemeData(trackHeight: 4, overlayShape: SliderComponentShape.noOverlay),
                child: Slider(
                  value: sliderValue > 1 ? sliderValue.floor().toDouble() : sliderValue,
                  min: 0,
                  max: 1,
                  onChanged: (value) => setState(() {
                    sliderValue = value;
                  }),
                  onChangeEnd: songNotifier.seek,
                  activeColor: AppColors.whiteColor,
                  inactiveColor: AppColors.whiteColor.withValues(alpha: 0.117),
                  thumbColor: AppColors.whiteColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(position!.inSeconds ~/ 60).floor().toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: AppColors.subtitleText,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '${(duration!.inSeconds ~/ 60).floor().toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: AppColors.subtitleText,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

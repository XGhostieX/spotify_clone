import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/song_model.dart';
import '../../../../../core/theme/app_colors.dart';

class LatestSongsItem extends StatelessWidget {
  final SongModel song;
  const LatestSongsItem({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: CachedNetworkImage(
            imageUrl: song.thumbnail,
            width: 160,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          song.name,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          song.artist,
          maxLines: 1,
          style: const TextStyle(
            color: AppColors.subtitleText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

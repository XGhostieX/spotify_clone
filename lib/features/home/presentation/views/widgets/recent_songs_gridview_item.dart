import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/song_model.dart';
import '../../../../../core/theme/app_colors.dart';

class RecentSongsGridviewItem extends StatelessWidget {
  final SongModel song;
  const RecentSongsGridviewItem({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: AppColors.cardColor),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(7),
            ),
            child: CachedNetworkImage(imageUrl: song.thumbnail, width: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              song.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

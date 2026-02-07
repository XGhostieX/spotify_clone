import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'latest_songs_listview.dart';

class HomeViewBody extends ConsumerWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latest Songs', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
            LatestSongsListview(),
          ],
        ),
      ),
    );
  }
}

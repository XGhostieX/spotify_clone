import 'package:flutter/material.dart';

// import 'widgets/home_view_body.dart';
import 'widgets/upload_song.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: UploadSong());
  }
}

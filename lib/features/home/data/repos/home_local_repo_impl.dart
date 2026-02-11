import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/song_model.dart';
import 'home_local_repo.dart';

part 'home_local_repo_impl.g.dart';

@riverpod
HomeLocalRepo homeLocalRepo(HomeLocalRepoRef ref) {
  return HomeLocalRepoImpl();
}

class HomeLocalRepoImpl implements HomeLocalRepo {
  final Box box = Hive.box();

  @override
  List<SongModel> loadSongs() {
    List<SongModel> songs = [];
    for (var key in box.keys) {
      songs.add(SongModel.fromMap(box.get(key)));
    }
    return songs;
  }

  @override
  void uploadSong(SongModel song) {
    box.put(song.id, song.toMap());
  }
}

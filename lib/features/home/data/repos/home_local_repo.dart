import '../../../../core/models/song_model.dart';

abstract class HomeLocalRepo {
  void uploadSong(SongModel song);
  List<SongModel> loadSongs();
}

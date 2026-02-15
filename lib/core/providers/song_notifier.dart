import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';

import '../../features/home/data/repos/home_local_repo.dart';
import '../../features/home/data/repos/home_local_repo_impl.dart';
import '../models/song_model.dart';

part 'song_notifier.g.dart';

@riverpod
class SongNotifier extends _$SongNotifier {
  late HomeLocalRepo _homeLocalRepo;
  AudioPlayer? _audioPlayer;
  bool _isPlaying = false;
  bool _isCompleted = false;
  @override
  SongModel? build() {
    _homeLocalRepo = ref.watch(homeLocalRepoProvider);
    return null;
  }

  void updateSong(SongModel song) async {
    await _audioPlayer?.stop();
    _audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(
      Uri.parse(song.url),
      tag: MediaItem(
        id: song.id,
        title: song.name,
        artist: song.artist,
        artUri: Uri.parse(song.thumbnail),
      ),
    );
    await _audioPlayer!.setAudioSource(audioSource);
    _audioPlayer!.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        _isPlaying = false;
        _isCompleted = true;
        state = state?.copyWith(color: state?.color);
      }
    });
    _homeLocalRepo.uploadSong(song);
    _audioPlayer!.play();
    _isPlaying = true;
    state = song;
  }

  void playPause() {
    if (_isCompleted) {
      _audioPlayer!.seek(Duration.zero);
      _audioPlayer?.play();
      _isCompleted = !_isCompleted;
    } else if (_isPlaying) {
      _audioPlayer?.pause();
    } else {
      _audioPlayer?.play();
    }
    _isPlaying = !_isPlaying;
    state = state?.copyWith(color: state?.color);
  }

  void seek(double value) {
    _audioPlayer!.seek(
      Duration(milliseconds: (value * _audioPlayer!.duration!.inMilliseconds).toInt()),
    );
  }

  AudioPlayer? audioPlayer() => _audioPlayer;
  bool isPlaying() => _isPlaying;
}

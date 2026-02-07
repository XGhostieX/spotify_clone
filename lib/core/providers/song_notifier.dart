import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';

part 'song_notifier.g.dart';

@Riverpod(keepAlive: true)
class SongNotifier extends _$SongNotifier {
  AudioPlayer? _audioPlayer;
  bool _isPlaying = false;
  bool _isCompleted = false;
  @override
  SongModel? build() {
    return null;
  }

  void updateSong(SongModel song) async {
    await _audioPlayer?.stop();
    _audioPlayer = AudioPlayer();
    final audioSource = AudioSource.uri(Uri.parse(song.url));
    await _audioPlayer!.setAudioSource(audioSource);
    _audioPlayer!.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        _isPlaying = false;
        _isCompleted = true;
        state = state?.copyWith(color: state?.color);
      }
    });
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

  AudioPlayer? audioPlayer() => _audioPlayer;
  bool isPlaying() => _isPlaying;
}

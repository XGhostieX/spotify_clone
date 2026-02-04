import 'dart:io';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/song_model.dart';
import '../../../../core/providers/user_notifier.dart';
import '../../../../core/utils/functions/color_switch.dart';
import '../../../../core/utils/functions/display_message.dart';
import '../../data/repos/home_remote_repo.dart';
import '../../data/repos/home_remote_repo_impl.dart';

part 'home_view_model.g.dart';

@riverpod
Future<List<SongModel>> fetchSongs(FetchSongsRef ref) async {
  final token = ref.watch(userNotifierProvider)!.token;
  final result = await ref.watch(homeRemoteRepoProvider).fetchSongs(token: token);
  return result.fold((failure) => throw failure.errMsg, (songs) => songs);
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final HomeRemoteRepo _homeRemoteRepo;
  @override
  AsyncValue? build() {
    _homeRemoteRepo = ref.watch(homeRemoteRepoProvider);
    return null;
  }

  Future<void> uploadSong({
    required File song,
    required File thumbnail,
    required String name,
    required String artist,
    required Color color,
  }) async {
    state = const AsyncValue.loading();
    final result = await _homeRemoteRepo.uploadSong(
      song: song,
      thumbnail: thumbnail,
      name: name,
      artist: artist,
      color: rgbToHex(color),
      token: ref.read(userNotifierProvider)!.token,
    );
    result.fold(
      (failure) {
        state = AsyncValue.error(failure.errMsg, StackTrace.current);
        displayMessage(failure.errMsg, true);
      },
      (song) {
        state = AsyncValue.data(song);
        displayMessage('Song uploaded Successfully!', false);
      },
    );
  }
}

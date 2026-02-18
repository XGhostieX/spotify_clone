import 'dart:io';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/user_notifier.dart';
import '../../../../core/utils/functions/color_switch.dart';
import '../../../../core/utils/functions/display_message.dart';
import '../../data/repos/upload_remote_repo.dart';
import '../../data/repos/upload_remote_repo_impl.dart';

part 'upload_view_model.g.dart';

@riverpod
class UploadViewModel extends _$UploadViewModel {
  late final UploadRemoteRepo _uploadRemoteRepo;
  @override
  AsyncValue? build() {
    _uploadRemoteRepo = ref.watch(uploadRemoteRepoProvider);
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
    final result = await _uploadRemoteRepo.uploadSong(
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

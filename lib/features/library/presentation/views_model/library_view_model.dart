import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/favorite_model.dart';
import '../../../../core/models/song_model.dart';
import '../../../../core/providers/user_notifier.dart';
import '../../../../core/utils/functions/display_message.dart';
import '../../data/repos/library_remote_repo.dart';
import '../../data/repos/library_remote_repo_impl.dart';

part 'library_view_model.g.dart';

@riverpod
Future<List<SongModel>> fetchFavoriteSongs(FetchFavoriteSongsRef ref) async {
  final token = ref.watch(userNotifierProvider)!.token;
  final result = await ref.watch(libraryRemoteRepoProvider).fetchFavoriteSongs(token: token);
  return result.fold((failure) => throw failure.errMsg, (songs) => songs);
}

@riverpod
class LibraryViewModel extends _$LibraryViewModel {
  late final LibraryRemoteRepo _libraryRemoteRepo;
  @override
  AsyncValue? build() {
    _libraryRemoteRepo = ref.watch(libraryRemoteRepoProvider);
    return null;
  }

  Future<void> favoriteSong({required String id}) async {
    state = const AsyncValue.loading();
    final result = await _libraryRemoteRepo.favoriteSong(
      id: id,
      token: ref.read(userNotifierProvider)!.token,
    );
    result.fold(
      (failure) {
        state = AsyncValue.error(failure.errMsg, StackTrace.current);
        displayMessage(failure.errMsg, true);
      },
      (favorite) {
        final userNotifier = ref.read(userNotifierProvider.notifier);
        if (favorite) {
          userNotifier.addUser(
            ref
                .read(userNotifierProvider)!
                .copyWith(
                  favorites: [
                    ...ref.read(userNotifierProvider)!.favorites,
                    FavoriteModel(id: '', songId: id, userId: ''),
                  ],
                ),
          );
        } else {
          userNotifier.addUser(
            ref
                .read(userNotifierProvider)!
                .copyWith(
                  favorites: ref
                      .read(userNotifierProvider)!
                      .favorites
                      .where((favorite) => favorite.songId != id)
                      .toList(),
                ),
          );
        }
        ref.invalidate(fetchFavoriteSongsProvider);
        state = AsyncValue.data(favorite);
      },
    );
  }
}

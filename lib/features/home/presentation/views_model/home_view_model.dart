import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/song_model.dart';
import '../../../../core/providers/user_notifier.dart';
import '../../data/repos/home_local_repo.dart';
import '../../data/repos/home_local_repo_impl.dart';
import '../../data/repos/home_remote_repo_impl.dart';

part 'home_view_model.g.dart';

@riverpod
Future<List<SongModel>> fetchRemoteSongs(FetchRemoteSongsRef ref) async {
  final token = ref.watch(userNotifierProvider.select((user) => user!.token));
  final result = await ref.watch(homeRemoteRepoProvider).fetchSongs(token: token);
  return result.fold((failure) => throw failure.errMsg, (songs) => songs);
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final HomeLocalRepo _homeLocalRepo;
  @override
  AsyncValue? build() {
    _homeLocalRepo = ref.watch(homeLocalRepoProvider);
    return null;
  }

  List<SongModel> fetchLocalSongs() {
    return _homeLocalRepo.loadSongs();
  }
}

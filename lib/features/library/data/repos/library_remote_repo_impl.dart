import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/song_model.dart';
import '../../../../core/utils/constants.dart';
import 'library_remote_repo.dart';

part 'library_remote_repo_impl.g.dart';

@riverpod
LibraryRemoteRepo libraryRemoteRepo(LibraryRemoteRepoRef ref) {
  return LibraryRemoteRepoImpl();
}

class LibraryRemoteRepoImpl implements LibraryRemoteRepo {
  @override
  Future<Either<Failure, bool>> favoriteSong({required String token, required String id}) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverURL}/song/favorite'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode({'id': id}),
      );
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(responseBody['message']);
      } else {
        return Left(ServerFailure.handleHttpException(response.statusCode, responseBody['detail']));
      }
    } catch (e) {
      return Left(ServerFailure.handleNetworkException(e));
    }
  }

  @override
  Future<Either<Failure, List<SongModel>>> fetchFavoriteSongs({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.serverURL}/song/list/favorites'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<SongModel> songs = [];
        for (var element in responseBody) {
          songs.add(SongModel.fromMap(element['song']));
        }
        return Right(songs);
      } else {
        return Left(ServerFailure.handleHttpException(response.statusCode, responseBody['detail']));
      }
    } catch (e) {
      return Left(ServerFailure.handleNetworkException(e));
    }
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/constants.dart';
import 'upload_remote_repo.dart';

part 'upload_remote_repo_impl.g.dart';

@riverpod
UploadRemoteRepo uploadRemoteRepo(UploadRemoteRepoRef ref) {
  return UploadRemoteRepoImpl();
}

class UploadRemoteRepoImpl implements UploadRemoteRepo {
  @override
  Future<Either<Failure, String>> uploadSong({
    required File song,
    required File thumbnail,
    required String name,
    required String artist,
    required String color,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Constants.serverURL}/song/upload'),
      );
      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song', song.path),
          await http.MultipartFile.fromPath('thumbnail', thumbnail.path),
        ])
        ..fields.addAll({'name': name, 'artist': artist, 'color': color})
        ..headers.addAll({'x-auth-token': token});
      final response = await request.send();
      if (response.statusCode == 201) {
        return Right(await response.stream.bytesToString());
      } else {
        return Left(
          ServerFailure.handleHttpException(
            response.statusCode,
            await response.stream.bytesToString(),
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure.handleNetworkException(e));
    }
  }
}

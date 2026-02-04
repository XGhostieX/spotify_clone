import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/song_model.dart';

abstract class HomeRemoteRepo {
  Future<Either<Failure, String>> uploadSong({
    required File song,
    required File thumbnail,
    required String name,
    required String artist,
    required String color,
    required String token,
  });
  Future<Either<Failure, List<SongModel>>> fetchSongs({required String token});
}

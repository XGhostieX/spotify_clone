import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/song_model.dart';

abstract class HomeRemoteRepo {
  Future<Either<Failure, List<SongModel>>> fetchSongs({required String token});
}

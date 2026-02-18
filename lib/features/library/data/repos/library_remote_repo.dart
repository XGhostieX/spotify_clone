import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/song_model.dart';

abstract class LibraryRemoteRepo {
  Future<Either<Failure, bool>> favoriteSong({required String token, required String id});
  Future<Either<Failure, List<SongModel>>> fetchFavoriteSongs({required String token});
}

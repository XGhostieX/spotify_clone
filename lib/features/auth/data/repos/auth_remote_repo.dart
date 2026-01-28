import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/user_model.dart';

abstract class AuthRemoteRepo {
  Future<Either<Failure, UserModel>> signin({required String email, required String password});
  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> getUserData({required String token});
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/constants.dart';
import 'auth_remote_repo.dart';

part 'auth_remote_repo_impl.g.dart';

@riverpod
AuthRemoteRepo authRemoteRepo(AuthRemoteRepoRef ref) {
  return AuthRemoteRepoImpl();
}

class AuthRemoteRepoImpl extends AuthRemoteRepo {
  @override
  Future<Either<Failure, UserModel>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverURL}/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(
          UserModel.fromMap(responseBody['user']).copyWith(token: responseBody['token']),
        );
      } else {
        return Left(AuthFailure.handleHttpException(response.statusCode, responseBody['detail']));
      }
    } catch (e) {
      return Left(AuthFailure.handleNetworkException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return Right(UserModel.fromMap(responseBody));
      } else {
        return Left(AuthFailure.handleHttpException(response.statusCode, responseBody['detail']));
      }
    } catch (e) {
      return Left(AuthFailure.handleNetworkException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.serverURL}/auth/'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(UserModel.fromMap(responseBody).copyWith(token: token));
      } else {
        return Left(AuthFailure.handleHttpException(response.statusCode, responseBody['detail']));
      }
    } catch (e) {
      return Left(AuthFailure.handleNetworkException(e));
    }
  }
}

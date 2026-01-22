import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/constants.dart';
import 'auth_repo.dart';

part 'auth_repo_impl.g.dart';

@riverpod
AuthRepo authRepo(AuthRepoRef ref) {
  return AuthRepoImpl();
}

class AuthRepoImpl extends AuthRepo {
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
        return Right(UserModel.fromMap(responseBody));
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
}

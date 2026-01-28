import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_local_repo.dart';

part 'auth_local_repo_impl.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepo authLocalRepo(AuthLocalRepoRef ref) {
  return AuthLocalRepoImpl();
}

class AuthLocalRepoImpl extends AuthLocalRepo {
  late SharedPreferences _sharedPreferences;

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void setToken(String? token) {
    if (token != null) {
      _sharedPreferences.setString('x-auth-token', token);
    }
  }

  @override
  String? getToken() {
    return _sharedPreferences.getString('x-auth-token');
  }
}

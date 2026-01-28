abstract class AuthLocalRepo {
  Future<void> init();
  void setToken(String? token);
  String? getToken();
}

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/providers/user_notifier.dart';
import '../../../../core/utils/functions/display_message.dart';
import '../../data/repos/auth_local_repo.dart';
import '../../data/repos/auth_local_repo_impl.dart';
import '../../data/repos/auth_remote_repo.dart';
import '../../data/repos/auth_remote_repo_impl.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRemoteRepo _authRemoteRepo;
  late final AuthLocalRepo _authLocalRepo;
  late final UserNotifier _userNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepo = ref.watch(authRemoteRepoProvider);
    _authLocalRepo = ref.watch(authLocalRepoProvider);
    _userNotifier = ref.watch(userNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepo.init();
  }

  Future<bool> signin({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final auth = await _authRemoteRepo.signin(email: email, password: password);
    return auth.fold(
      (failure) {
        state = AsyncValue.error(failure.errMsg, StackTrace.current);
        displayMessage(failure.errMsg, true);
        return false;
      },
      (user) {
        _authLocalRepo.setToken(user.token);
        _userNotifier.addUser(user);
        state = AsyncValue.data(user);
        displayMessage('Welcome Back ${user.name}', false);
        return true;
      },
    );
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final auth = await _authRemoteRepo.signup(name: name, email: email, password: password);
    return auth.fold(
      (failure) {
        state = AsyncValue.error(failure.errMsg, StackTrace.current);
        displayMessage(failure.errMsg, true);
        return false;
      },
      (user) {
        state = AsyncValue.data(user);
        displayMessage('Welcome ${user.name}', false);
        return true;
      },
    );
  }

  Future<UserModel?> getUserData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepo.getToken();
    if (token != null) {
      final response = await _authRemoteRepo.getUserData(token: token);
      return response.fold(
        (failure) {
          state = AsyncValue.error(failure.errMsg, StackTrace.current);
          displayMessage(failure.errMsg, true);
          return null;
        },
        (user) {
          state = AsyncValue.data(user);
          _userNotifier.addUser(user);
          displayMessage('Welcome Back ${user.name}', false);
          return user;
        },
      );
    }
    return null;
  }
}

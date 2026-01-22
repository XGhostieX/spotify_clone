import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/utils/functions/display_message.dart';
import '../../data/repos/auth_repo.dart';
import '../../data/repos/auth_repo_impl.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRepo _authRepo;
  @override
  AsyncValue<UserModel>? build() {
    _authRepo = ref.watch(authRepoProvider);
    return null;
  }

  Future<void> signin({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final auth = await _authRepo.signin(email: email, password: password);
    auth.fold(
      (failure) {
        state = AsyncValue.error(failure.errMsg, StackTrace.current);
        displayMessage(failure.errMsg, true);
      },
      (user) {
        state = AsyncValue.data(user);
        displayMessage('Welcome ${user.name}', false);
      },
    );
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final auth = await _authRepo.signup(name: name, email: email, password: password);
    auth.fold(
      (failure) {
        state = AsyncValue.error(failure.errMsg, StackTrace.current);
        displayMessage(failure.errMsg, true);
      },
      (user) {
        state = AsyncValue.data(user);
        displayMessage('Welcome ${user.name}', false);
      },
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {}

final authRepoProvider = Provider((ref) => AuthRepoImpl());

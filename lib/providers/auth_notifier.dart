import 'package:monkey_shop/data/repository/user_repository.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:monkey_shop/utils/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  late final UserRepository _userRepository;

  @override
  Future<User>? build() {
    _userRepository = UserRepository(db);
    return null;
  }

  void auth(User user) async {
    state = AsyncLoading();
    await Future.delayed(Duration(seconds: 2));
    var isAuth = await _userRepository.isAuth(user);
    state = AsyncData(isAuth);
  }

  void addUser(User user) {
    _userRepository.addUser(user);
  }
}

var authProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

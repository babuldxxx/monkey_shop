import 'package:monkey_shop/data/repository/user_repository.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  late final UserRepository _userRepository;

  @override
  Future<User?> build() async {
    _userRepository = UserRepository();
    return null;
  }

  Future<void> auth(String login, String password) async {
    state = const AsyncLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500));

      final user = await _userRepository.isAuth(login, password);

      if(user != null){
        state = AsyncData(user);
      } else {
        state = const AsyncData(null);
        throw Exception('Неверный логин или пароль');
      }
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> register(User user) async {
    state = const AsyncLoading();
    try {
      await _userRepository.addUser(user);

      final newUser = await _userRepository.isAuth(user.login, user.password);
      state = AsyncData(newUser);
    } catch (error, stackTrace){
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> logout() async {
    state = const AsyncData(null);
  }
}

var authProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

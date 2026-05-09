import 'dart:developer' as console;

import 'package:drift/drift.dart';
import 'package:monkey_shop/data/remote/firebase_user_service.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:monkey_shop/utils/connectivity_service.dart';
import 'package:monkey_shop/utils/database.dart';

class UserRepository {
  final Database _database = db;
  final FirebaseUserService _firebaseUserService = FirebaseUserService();

  Future<void> fullSync() async {
    if (!await ConnectivityService.hasInternet()) return;

    try {
      final localUsers = await getUsers();
      for (final user in localUsers) {
        final exists = await _firebaseUserService.userExists(user.id);

        if (!exists) {
          await _firebaseUserService.upsertUser(user);

          console.log('Пользователь ${user.id} добавлен в Firebase');
        }
      }

      final cloudUsers = await _firebaseUserService.fetchAllUsers();

      await _database.delete(_database.userData).go();
      for (final user in cloudUsers) {
        await _database
            .into(_database.userData)
            .insert(user.toDtoWithId(), mode: InsertMode.insertOrRollback);
      }
      console.log('Полная синхронизация пользователей завершена');
    } catch (error) {
      console.log('Ошибка синхронизации: $error');
    }
  }

  Future<List<User>> getUsers() async {
    var rows = await _database.select(_database.userData).get();
    return rows.map((user) => user.toDomain()).toList();
  }

  Future<User?> isAuth(String login, String password) async {
    var res = await _database.select(_database.userData).get();

    for (var tmpUser in res) {
      if (tmpUser.login == login && tmpUser.password == password) {
        return tmpUser.toDomain();
      }
    }

    return Future.value(null);
  }

  Future<bool> isLoginExists(String login) async {
    var res = await _database.select(_database.userData).get();
    return res.any((user) => user.login == login);
  }

  Future<void> addUser(User user) async {
    bool exists = await isLoginExists(user.login);
    if (exists) {
      throw Exception('Пользователь с таким логином уже существует');
    }

    final insertedId = await _database.into(_database.userData).insert(user.toDto());
    final newUser = User(
      id: insertedId,
      name: user.name,
      login: user.login,
      password: user.password,
      role: user.role,
    );

    if(await ConnectivityService.hasInternet()){
      await _firebaseUserService.upsertUser(newUser);
    }
  }
}

extension UserMapper on UserDto {
  User toDomain() {
    return User(
      id: id,
      name: name,
      login: login,
      password: password,
      role: role,
    );
  }
}

extension UserFullDtoMapper on User {
  UserDataCompanion toDtoWithId() {
    return UserDataCompanion(
      id: Value(id),
      name: Value(name),
      login: Value(login),
      password: Value(password),
      role: Value(role),
    );
  }
}

extension UserDtoMapper on User {
  UserDataCompanion toDto() {
    return UserDataCompanion(
      name: Value(name),
      login: Value(login),
      password: Value(password),
      role: Value(role),
    );
  }
}

import 'package:drift/drift.dart';
import 'package:flutter_application_1/domain/models/user.dart';
import 'package:flutter_application_1/utils/database.dart';

class UserRepository {
  final Database _database;

  UserRepository(this._database);

  Future<List<User>> getUsers() async {
    var list = await _database.select(_database.userDto).get();
    return list.map((user) => user.toDomain()).toList();
  }

  Future<User?> isAuth(User user) async {
    var res = await _database.select(_database.userDto).get();

    for (var tmpUser in res) {
      if (tmpUser.login == user.login && tmpUser.password == user.password) {
        return tmpUser.toDomain();
      }
    }

    return Future.value(null);
  }

  void addUser(User user) {
    _database.into(_database.userDto).insert(user.toDto());
  }
}

extension UserMapper on UserData {
  User toDomain() {
    return User(name: name, login: login, password: password);
  }
}

extension UserDtoMapper on User {
  UserDtoCompanion toDto() {
    return UserDtoCompanion(
      name: Value(name),
      login: Value(login),
      password: Value(password),
    );
  }
}

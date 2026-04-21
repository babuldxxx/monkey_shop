import 'package:drift/drift.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:monkey_shop/utils/database.dart';

class UserRepository {
  final Database _database;

  UserRepository(this._database);

  Future<List<User>> getUsers() async {
    var rows = await _database.select(_database.userData).get();
    return rows.map((user) => user.toDomain()).toList();
  }

  Future<User?> isAuth(String login, String password) async {
    var res = await _database.select(_database.userData).get();

    for (var user in res) {
      if (user.login == user.login && user.password == user.password) {
        return user.toDomain();
      }
    }

    return Future.value(null);
  }

  Future<void> addUser(User user) async{
    await _database.into(_database.userData).insert(user.toDto());
  }
}

extension UserMapper on UserDto {
  User toDomain() {
    return User(id: id, name: name, login: login, password: password, role: role);
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

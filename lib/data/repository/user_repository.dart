import 'package:drift/drift.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:monkey_shop/utils/database.dart';

class UserRepository {
  final Database _database = db;

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

  Future<bool> isLoginExists(String login) async{
    var res = await _database.select(_database.userData).get();
    return res.any((user) => user.login == login);
  }

  Future<void> addUser(User user) async{
    bool exists = await isLoginExists(user.login);

    if(exists){
      throw Exception('Пользователь с таким логином уже существует');
    }

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

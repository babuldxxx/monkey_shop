import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase(tables: [UserDto])
class Database extends _$Database {
  Database(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        await batch((b) {
          b.insertAll(userDto, [
            UserDtoCompanion.insert(name: '1', login: '1', password: '1'),
          ]);
        });
      },
    );
  }
}

@DataClassName('UserData')
abstract class UserDto extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get login => text()();

  TextColumn get password => text()();
}

final db = Database(NativeDatabase.memory());

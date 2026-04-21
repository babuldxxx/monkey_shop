import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

@DriftDatabase(tables: [UserData, ProductData])
class Database extends _$Database {
  Database(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        await batch((b) {
          b.insertAll(userData, [
            UserDataCompanion(
              name: Value("Admin"),
              login: Value('admin'),
              password: Value('admin'),
              role: Value('admin'),
            ),
          ]);
        });
      },
    );
  }
}

@DataClassName('UserDto')
abstract class UserData extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get login => text()();

  TextColumn get password => text()();

  TextColumn get role => text().withDefault(const Constant('user'))();
}

@DataClassName('ProductDto')
abstract class ProductData extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  BlobColumn? get imageData  => blob().nullable()();

  BoolColumn get isActive => boolean().withDefault(Constant(false))();

  TextColumn get qrData => text()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}


final db = Database(NativeDatabase.memory());

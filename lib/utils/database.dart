import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';

part 'database.g.dart';

@DriftDatabase(tables: [UserData, ProductData, TakeData])
class Database extends _$Database {
  Database(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        await batch((b) async {
          b.insertAll(userData, [
            UserDataCompanion.insert(
              name: "Admin",
              login: 'sonykksss',
              password: 'sonykksss',
              role: Value('admin'),
            ),
          ]);

          Uint8List? productImage;
          try{
            final ByteData imageData = await rootBundle.load('assets/mom.jpg');
            productImage = imageData.buffer.asUint8List();
          } catch (error){
            productImage = null;
          }

          b.insertAll(productData, [
            ProductDataCompanion.insert(
              name: 'product 1',
              description: 'description product 1',
              imageData: productImage == null ? const Value.absent() : Value(productImage),
              status: 'свободен',
              qrData: 'product 1',
              createdBy: 1,
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
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

  BlobColumn? get imageData => blob().nullable()();

  TextColumn get status => text()();

  TextColumn get qrData => text()();

  IntColumn get createdBy => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}

@DataClassName('TakeDto')
abstract class TakeData extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()();

  IntColumn get productId => integer()();

  DateTimeColumn get takenAt => dateTime()();

  DateTimeColumn get returnedAt => dateTime().nullable()();
}

final db = Database(NativeDatabase.memory());

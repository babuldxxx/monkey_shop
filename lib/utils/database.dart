import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';

part 'database.g.dart';

@DriftDatabase(tables: [UserData, ProductData, TakeData])
class Database extends _$Database {
  Database(super.e);
  
  static Future<Uint8List?> loadImageFromAssets(String assetPath)  async {
    try{
      final ByteData imageData =  await rootBundle.load(assetPath);
      return imageData.buffer.asUint8List();
    } catch(error){
      return null;
    }
  }

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
          

          b.insertAll(productData, [
            ProductDataCompanion.insert(
              name: 'Punch`s mother',
              description: 'Игрушечная мама Панча из Икеи.',
              imageData: Value(await loadImageFromAssets('assets/mom.jpg')),
              status: 'available',
              qrData: 'Punch`s mother',
              createdBy: 1,
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
            ProductDataCompanion.insert(
              name: 'Punch with mom',
              description: 'Панча бросила его настоящая мама. Теперь мамой он считает игрушку, в которой видит защиту',
              imageData: Value(await loadImageFromAssets('assets/punch_with_mom.jpg')),
              status: 'available',
              qrData: 'Punch with mom',
              createdBy: 1,
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
            ProductDataCompanion.insert(
              name: 'Punch is sad',
              description: 'Панча обижают его сородичи, поэтому ему грустно и страшно. От врагов он прикрывается плюшевой мамой.',
              imageData: Value(await loadImageFromAssets('assets/punch_is_sad.jpg')),
              status: 'available',
              qrData: 'Punch is sad',
              createdBy: 1,
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
            ProductDataCompanion.insert(
              name: 'Punch with a new friend',
              description: 'Панча приняла одна из обезьян и теперь он не одинок.',
              imageData: Value(await loadImageFromAssets('assets/punch_with_friend.jpg')),
              status: 'available',
              qrData: 'Punch with a new friend',
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

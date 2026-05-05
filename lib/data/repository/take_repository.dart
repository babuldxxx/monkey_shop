import 'package:drift/drift.dart';
import 'package:monkey_shop/utils/database.dart';

class TakeRepository {
  final Database _db = db;

  TakeRepository();

  Future<void> createTake(int userId, int productId) async {
    await _db.into(_db.takeData).insert(TakeDataCompanion(
      userId: Value(userId),
      productId: Value(productId),
      takenAt: Value(DateTime.now()),
    ));
    await (_db.update(_db.productData)
        ..where((tbl) => tbl.id.equals(productId)))
        .write(ProductDataCompanion(status: const Value('taken')));
  }

  Future<void> returnTake(int productId) async {
    final takes = await (_db
        .select(_db.takeData)
        ..where((t) => t.productId.equals(productId) & t.returnedAt.isNull()))
        .get();

    if (takes.isNotEmpty) {
      final take = takes.first;
      await (_db.update(_db.takeData)..where((t) => t.id.equals(take.id))).write(
        TakeDataCompanion(returnedAt: Value(DateTime.now())),
      );
      await (_db.update(_db.productData)..where((p) => p.id.equals(productId))).write(
        ProductDataCompanion(status: const Value('available')),
      );
    }
  }
}

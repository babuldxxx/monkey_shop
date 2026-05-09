import 'package:drift/drift.dart';
import 'package:monkey_shop/data/remote/firebase_product_service.dart';
import 'package:monkey_shop/data/repository/product_repository.dart';
import 'package:monkey_shop/utils/connectivity_service.dart';
import 'package:monkey_shop/utils/database.dart';

class TakeRepository {
  final Database _db = db;
  final FirebaseProductService _firebaseService = FirebaseProductService();

  Future<void> createTake(int userId, int productId) async {
    await _db
        .into(_db.takeData)
        .insert(
          TakeDataCompanion(
            userId: Value(userId),
            productId: Value(productId),
            takenAt: Value(DateTime.now()),
          ),
        );

    await (_db.update(_db.productData)
      ..where((tbl) => tbl.id.equals(productId))).write(
      ProductDataCompanion(status: const Value('taken'))
    );

    await _syncProductStatusToCloud(productId);
  }

  Future<void> returnTake(int productId) async {
    final takes =
        await (_db.select(_db.takeData)..where(
              (t) => t.productId.equals(productId) & t.returnedAt.isNull(),
            ))
            .get();

    if (takes.isNotEmpty) {
      final take = takes.first;

      await (_db.update(_db.takeData)..where((t) => t.id.equals(take.id)))
          .write(TakeDataCompanion(returnedAt: Value(DateTime.now())));

      await (_db.update(_db.productData)..where((p) => p.id.equals(productId)))
          .write(ProductDataCompanion(status: const Value('available')));

      await _syncProductStatusToCloud(productId);
    }
  }

  Future<void> _syncProductStatusToCloud(int productId) async {
    if(!await ConnectivityService.hasInternet()) return;

    final productRow = await (_db.select(_db.productData)..where((p) => p.id.equals(productId))).getSingleOrNull();

    if(productRow != null){
      final product = productRow.toDomain();
      await _firebaseService.upsertProduct(product);
    }
  }

  Future<bool> isProductTakenByUser(int productId, int userId) async {
    final take =
        await (_db.select(_db.takeData)..where(
              (t) =>
                  t.productId.equals(productId) &
                  t.userId.equals(userId) &
                  t.returnedAt.isNull(),
            ))
            .getSingleOrNull();

    return take != null;
  }
}

import 'package:drift/drift.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:monkey_shop/utils/database.dart';

class ProductRepository {
  final Database _database = db;

  Future<List<Product>> getProducts() async {
    final rows = await _database.select(_database.productData).get();
    return rows.map((row) => row.toDomain()).toList();
  }

  Future<Product?> getProductById(int id) async {
    final row = await (_database.select(_database.productData)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  Future<void> addProduct(Product product) async {
    await _database.into(_database.productData).insert(product.toDto());
  }

  Future<void> deleteProduct(int id) async {
    await (_database.delete(
      _database.productData,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> updateProduct(Product product) async {
    await (_database.update(
      _database.productData,
    )..where((tbl) => tbl.id.equals(product.id!))).write(product.toDto());
  }

  bool canUserEditProduct(Product product, User? currentUser){
    if(currentUser == null) return false;

    if(currentUser.isAdmin) return true;

    return product.createdBy == currentUser.id;
  }

  bool canUserDeleteProduct(Product product, User? currentUser){
    return canUserEditProduct(product, currentUser);
  }
}

extension ProductMapper on ProductDto {
  Product toDomain() {
    return Product(
      id: id,
      name: name,
      description: description,
      imageData: imageData,
      status: status,
      qrData: qrData,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt
    );
  }
}

extension ProductDtoMapper on Product {
  ProductDataCompanion toDto() {
    return ProductDataCompanion(
      name: Value(name),
      description: Value(description),
      imageData: Value(imageData),
      status: Value(status),
      qrData: Value(qrData),
      createdBy: Value(createdBy ?? 1),
      createdAt: Value(createdAt ?? DateTime.now()),
      updatedAt: Value(updatedAt ?? DateTime.now()),
    );
  }
}


import 'dart:developer' as console;

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:monkey_shop/data/remote/firebase_product_service.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:monkey_shop/utils/connectivity_service.dart';
import 'package:monkey_shop/utils/database.dart';

class ProductRepository {
  final Database _database = db;
  final FirebaseProductService _firebaseProductService =
      FirebaseProductService();

  Future<List<Product>> getProducts() async {
    final rows = await _database.select(_database.productData).get();
    return rows.map((row) => row.toDomain()).toList();
  }

  Future<Product?> getProductById(int id) async {
    final row = await (_database.select(
      _database.productData,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toDomain();
  }

  Future<void> addProduct(Product product) async {
    final insertedId = await _database
        .into(_database.productData)
        .insert(product.toDto());
    final newProduct = Product(
      id: insertedId,
      name: product.name,
      description: product.description,
      imageData: product.imageData,
      status: product.status,
      qrData: product.qrData,
      createdBy: product.createdBy,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (await ConnectivityService.hasInternet()) {
      try {
        await _firebaseProductService.upsertProduct(newProduct);
      } catch (e) {
        console.log('Ошибка синхронизации добавления: $e');
      }
    }
  }

  Future<void> deleteProduct(int id) async {
    await (_database.delete(
      _database.productData,
    )..where((tbl) => tbl.id.equals(id))).go();

    if (await ConnectivityService.hasInternet()) {
      try {
        await _firebaseProductService.deleteProduct(id);
      } catch (e) {
        console.log('Ошибка синхронизации удаления: $e');
      }
    }
  }

  Future<void> updateProduct(Product product) async {
    await (_database.update(
      _database.productData,
    )..where((tbl) => tbl.id.equals(product.id!))).write(product.toDto());

    if (await ConnectivityService.hasInternet()) {
      try {
        await _firebaseProductService.upsertProduct(product);
      } catch (e) {
        console.log('Ошибка синхронизации обновления: $e');
      }
    }
  }

  Future<void> fullSync() async {
    if (!await ConnectivityService.hasInternet()) return;

    try {
      final localProducts = await getProducts();
      for (final product in localProducts) {
        if (product.id == null) continue;
        final exists = await _firebaseProductService.productExists(product.id!);
        if (!exists) {
          await _firebaseProductService.upsertProduct(product);
          console.log('Товар ${product.id} добавлен в Firebase');
        }
      }

      final cloudProducts = await _firebaseProductService.fetchAllProducts();

      await _database.delete(_database.productData).go();
      for (final product in cloudProducts) {
        await _database
            .into(_database.productData)
            .insert(product.toDtoWithId(), mode: InsertMode.insertOrRollback);
      }

      if (kDebugMode) {
        print('Полная сихнронизация товаров завершена');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка синхронизации: $e');
      }
    }
  }

  bool canUserEditProduct(Product product, User? currentUser) {
    if (currentUser == null) return false;

    if (currentUser.isAdmin) return true;

    return product.createdBy == currentUser.id;
  }

  bool canUserDeleteProduct(Product product, User? currentUser) {
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
      updatedAt: updatedAt,
    );
  }
}

extension ProductFullDtoMapper on Product {
  ProductDataCompanion toDtoWithId() {
    return ProductDataCompanion(
      id: Value(id!),
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

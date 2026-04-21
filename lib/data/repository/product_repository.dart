import 'package:drift/drift.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:monkey_shop/utils/database.dart';

class ProductRepository {
  final Database _database = db;

  Future<List<Product>> getProducts() async {
    final productDtos = await _database.select(_database.productData).get();
    return productDtos.map((dto) => dto.toDomain()).toList();
  }

  Future<void> addProduct(Product product) async {
    await _database.into(_database.productData).insert(product.toDto());
  }

  Future<void> deleteProduct(int id) async {
    await (_database.delete(
      _database.productData,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> updateProduct(int id, Product product) async {
    await (_database.update(
      _database.productData,
    )..where((tbl) => tbl.id.equals(id))).write(product.toDto());
  }
}

extension ProductMapper on ProductDto {
  Product toDomain() {
    return Product(
      id: id,
      name: name,
      imageData: imageData,
      description: description,
      isActive: isActive,
      qrData: qrData,
    );
  }
}

extension ProductDtoMapper on Product {
  ProductDataCompanion toDto() {
    return ProductDataCompanion(
      name: Value(name),
      imageData: Value(imageData),
      description: Value(description),
      isActive: Value(isActive),
      qrData: Value(qrData),
    );
  }
}

// static final List<Product> _products = [
//   Product(
//     name: 'Punch`s mother',
//     pathImage: 'assets/mom.jpg',
//     description: 'Игрушечная мама Панча из Икеи.',
//     qrData: 'Data 1',
//   ),
//   Product(
//     name: 'Punch with mom ',
//     pathImage: 'assets/punch_with_mom.jpg',
//     description:
//     'Панча бросила его настоящая мама. Теперь мамой он считает игрушку, в которой видит защиту',
//     qrData: 'Data 1',
//   ),
//   Product(
//     name: 'Punch is sad',
//     pathImage: 'assets/punch is sad.jpg',
//     description:
//     'Панча обижают его сородичи, поэтому ему грустно и страшно. От врагов он прикрывается плюшевой мамой.',
//     qrData: 'Data 1',
//     status: true,
//   ),
//   Product(
//     name: 'Punch with a new friend',
//     pathImage: 'assets/punch witn friend.jpg',
//     description: 'Панча приняла одна из обезьян и теперь он не одинок.',
//     qrData: 'Data 1',
//     status: true,
//   ),
// ];

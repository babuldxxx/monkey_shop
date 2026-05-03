import 'package:monkey_shop/data/repository/product_repository.dart';
import 'package:monkey_shop/data/repository/take_repository.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends Notifier<List<Product>> {
  late final ProductRepository _productRepository;
  late final TakeRepository _takeRepository;

  @override
  List<Product> build() {
    _productRepository = ProductRepository();
    _takeRepository = TakeRepository();

    loadProduct();

    return [];
  }

  Future<void> loadProduct() async {
    final products = await _productRepository.getProducts();
    state = List<Product>.from(products);
  }

  Future<void> addProduct(Product product) async {
    await _productRepository.addProduct(product);
    await loadProduct();
  }

  Future<void> deleteProduct(int id) async {
    await _productRepository.deleteProduct(id);
    state = state.where((p) => p.id != id).toList();
  }

  Future<void> updateProduct(Product product) async {
    await _productRepository.updateProduct(product);
    state = state.map((p) => p.id == product.id ? product : p).toList();
  }

  Future<void> takeProduct(int productId, int userId) async{
    await _takeRepository.createTake(userId, productId);
    await loadProduct();
  }

  Future<void> returnProduct(int productId) async{
    await _takeRepository.returnTake(productId);
    await loadProduct();
  }
}

var productProvider = NotifierProvider<ProductNotifier, List<Product>>(
  ProductNotifier.new,
);

import 'package:flutter_application_1/data/repository/product_repository.dart';
import 'package:flutter_application_1/domain/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends Notifier<List<Product>> {
  late final ProductRepository _productRepository;
  @override
  List<Product> build() {
    final productRepository = ProductRepository();
    return productRepository.getProducts();
  }

  void addProduct(Product product) {
    _productRepository.addProduct(product);
    state = [...state, product];
  }

  void removeProduct(int index) {
    final newList = List<Product>.from(state);
    newList.removeAt(index);
    state = newList;
  }
}

var productProvider = NotifierProvider<ProductNotifier, List<Product>>(
  ProductNotifier.new,
);

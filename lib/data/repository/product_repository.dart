import 'package:flutter_application_1/domain/models/product.dart';

class ProductRepository {
  static final List<Product> _products = [
    Product(
      name: 'Punch`s mother',
      pathImage: 'assets/mom.jpg',
      description: 'Игрушечная мама Панча из Икеи.',
      qrData: 'Data 1',
    ),
    Product(
      name: 'Punch with mom ',
      pathImage: 'assets/punch_with_mom.jpg',
      description:
          'Панча бросила его настоящая мама. Теперь мамой он считает игрушку, в которой видит защиту',
      qrData: 'Data 1',
    ),
    Product(
      name: 'Punch is sad',
      pathImage: 'assets/punch is sad.jpg',
      description:
          'Панча обижают его сородичи, поэтому ему грустно и страшно. От врагов он прикрывается плюшевой мамой.',
      qrData: 'Data 1',
      isActive: true,
    ),
    Product(
      name: 'Punch with a new friend',
      pathImage: 'assets/punch witn friend.jpg',
      description: 'Панча приняла одна из обезьян и теперь он не одинок.',
      qrData: 'Data 1',
      isActive: true,
    ),
  ];

  List<Product> getProducts() {
    return _products;
  }

  void addProduct(Product product) {
    _products.add(product);
  }
}

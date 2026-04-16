import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/product_notifier.dart';
import 'package:flutter_application_1/screens/product_details_screen.dart';
import 'package:flutter_application_1/screens/qr_scanner_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/product_cart.dart';
import '../screens/add_product_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var products = ref.read(productProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 172, 160),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRScannerScreen(products: products),
                ),
              );
            },
            icon: const Icon(Icons.camera_alt_rounded),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 20),
            child: ProductCart(
              product: products[index],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(product: products[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

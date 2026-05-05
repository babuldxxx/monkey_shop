import 'package:flutter/material.dart';
import 'package:monkey_shop/providers/auth_notifier.dart';
import 'package:monkey_shop/providers/product_notifier.dart';
import 'package:monkey_shop/screens/auth_screen.dart';
import 'package:monkey_shop/screens/product_details_screen.dart';
import 'package:monkey_shop/screens/qr_scanner_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/product_card.dart';
import '../screens/add_product_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final authState = ref.watch(authProvider);

    final currentUser = authState.value;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 172, 160),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRScannerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.camera_alt_rounded),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Выход из аккаунта'),
                    content: const Text(
                      'Вы уверены, что хотите выйти из аккаунт?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Выйти'),
                      ),
                    ],
                  );
                },
              );
              if (shouldLogout == true) {
                await ref.read(authProvider.notifier).logout();

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                    (route) => false,
                  );
                }
              }
            },
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: Text('Нет доступных товаров'))
          : ListView.builder(
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
      floatingActionButton: currentUser?.isAdmin == true
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

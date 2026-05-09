import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:monkey_shop/providers/auth_notifier.dart';
import 'package:monkey_shop/providers/product_notifier.dart';
import 'package:monkey_shop/screens/add_product_screen.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final authState = ref.watch(authProvider);
    final currentUser = authState.value;
    final isAdmin = currentUser?.isAdmin ?? false;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF5E6),

      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 222, 184, 165),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.brown),

        actions: isAdmin
            ? [
                IconButton(
                  onPressed: () => _navigateToEditScreen(context, product),
                  icon: const Icon(Icons.edit, color: Colors.brown),
                ),

                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteDialog(context, product),
                ),
              ]
            : null,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: widget.product.imageData != null
                    ? Image.memory(widget.product.imageData!)
                    : Image.asset('assets/mom.jpg'),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color.fromARGB(248, 222, 181, 158),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.production_quantity_limits_outlined,
                          color: Color.fromARGB(248, 222, 181, 158),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Container(
                    height: 2,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 20),
                  if (widget.product.description.isNotEmpty)
                    Text(
                      'Описание',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown[700],
                      ),
                    ),

                  const SizedBox(height: 8),
                  if (widget.product.description.isNotEmpty)
                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.2,
                        color: Colors.brown[800],
                      ),
                    ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Статус: ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: widget.product.isActive
                              ? Colors.blue
                              : Colors.red,
                        ),
                        child: Text(
                          widget.product.isActive ? 'Свободен' : 'Занят',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  PrettyQrView(
                    qrImage: QrImage(
                      QrCode(8, QrErrorCorrectLevel.H)
                        ..addData(widget.product.qrData),
                    ),
                    decoration: const PrettyQrDecoration(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удаление товаров'),
          content: Text(
            'Вы уверены, что хотите удалить товар "${product.name}"?',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _deleteProduct(product);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(Product product) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      await ref.read(productProvider.notifier).deleteProduct(product.id!);

      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Товар "${product.name}" успешно удален'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      }
    } catch (error) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при удалении: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToEditScreen(BuildContext context, Product product){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductScreen(product: product)
      )
    ).then((_){
      if(mounted){
        ref.read(productProvider.notifier).loadProduct();
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monkey_shop/data/repository/product_repository.dart';
import 'package:monkey_shop/data/repository/take_repository.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:monkey_shop/providers/auth_notifier.dart';
import 'package:monkey_shop/providers/product_notifier.dart';
import 'package:monkey_shop/screens/product_details_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  final List<Product> products;

  const QRScannerScreen({super.key, required this.products});

  @override
  ConsumerState<QRScannerScreen> createState() => _QRScannerScreen();
}

class _QRScannerScreen extends ConsumerState<QRScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController(
    autoStart: true,
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );


  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        _findAndNavigate(barcode.rawValue!);
        break;
      }
    }
  }

  void _findAndNavigate(String qrData) async {

    final products = ref.read(productProvider);

    Product foundProduct = products.firstWhere(
      (product) => product.qrData == qrData,
    );

    final authState = ref.read(authProvider);
    final currentUser = authState.value;
    final takeRepository = TakeRepository();

    if (foundProduct.status == 'свободен') {
      final confirm = await _showConfirmationDialog(
        'Взять товар',
        'Вы хотите взять товар "${foundProduct.name}"?',
      );

      if (confirm == true) {
        await takeRepository.createTake(currentUser!.id, foundProduct.id!);
        await ref.read(productProvider.notifier).loadProduct();

        if (mounted) {
          await _showSuccessDialog(
            'Товар взят',
            'Вы успешно взяли товар "${foundProduct.name}"',
          );

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(product: foundProduct),
              ),
            );
          }
        }
      }
    } else if (foundProduct.status == 'занят') {
      final isTakenByUser = await takeRepository.isProductTakenByUser(
        foundProduct.id!,
        currentUser!.id,
      );

      if (isTakenByUser) {
        final confirm = await _showConfirmationDialog(
          'Вернуть товар',
          'Вы хотите вернуть товар "${foundProduct.name}"?',
        );

        if (confirm == true) {
          await takeRepository.returnTake(foundProduct.id!);
          await ref.read(productProvider.notifier).loadProduct();

          if (mounted) {
            await _showSuccessDialog(
              'Товар возвращен',
              'Вы успешно вернули товар "${foundProduct.name}"',
            );

            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsScreen(product: foundProduct),
                ),
              );
            }
          }
        }
      }
    }
  }

  Future<bool?> _showConfirmationDialog(String title, String content) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: const Text('Подтвердить'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(String title, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSuccessDialog(String title, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сканировать QR-код'),
        backgroundColor: const Color.fromARGB(255, 203, 172, 160),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(controller: cameraController, onDetect: _onDetect),
        ],
      ),
    );
  }
}

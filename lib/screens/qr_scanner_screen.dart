import 'package:flutter/material.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:monkey_shop/domain/models/user.dart';
import 'package:monkey_shop/screens/product_details_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:monkey_shop/data/repository/product_repository.dart';
import 'package:monkey_shop/data/repository/take_repository.dart';
import 'package:monkey_shop/providers/auth_notifier.dart';
import 'package:monkey_shop/providers/product_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({super.key});

  @override
  ConsumerState<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends ConsumerState<QRScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    for (final barcode in capture.barcodes) {
      if (barcode.rawValue != null) {
        await _handleScan(barcode.rawValue!);
        break;
      }
    }
  }

  Future<void> _handleScan(String qrData) async {
    final productRepo = ProductRepository();
    final products = await productRepo.getProducts();
    Product? product = products.firstWhere((p) => p.qrData == qrData);

    final currentUserAsync = ref.read(authProvider);
    final User? currentUser = currentUserAsync.value;
    final int userId = currentUser?.id ?? 1;
    final takeRepo = TakeRepository();
    if (product.isActive) {
      await takeRepo.createTake(userId, product.id!);
    } else {
      await takeRepo.returnTake(product.id!);
    }

    await ref.read(productProvider.notifier).loadProduct();
    final updatedList = ref.read(productProvider);
    final updatedProduct = updatedList.firstWhere(
      (p) => p.qrData == qrData,
      orElse: () => product,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: updatedProduct),
      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/product.dart';
import 'package:flutter_application_1/screens/product_details_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  final List<Product> products;

  const QRScannerScreen({super.key, required this.products});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreen();
}

class _QRScannerScreen extends State<QRScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController(
    autoStart: true,
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  bool isProcessing = false;

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

  void _findAndNavigate(String qrData) {
    setState(() {
      isProcessing = true;
    });

    Product? foundProduct = widget.products.firstWhere(
      (product) => product.qrData == qrData,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: foundProduct),
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

import 'dart:typed_data';

class Product {
  final int? id;
  final String name;
  final Uint8List? imageData;
  final String description;
  final bool isActive;
  final String qrData;

  Product({
    this.id,
    required this.name, 
    this.imageData,
    this.description = "",
    this.isActive = false,
    required this.qrData
    });
}
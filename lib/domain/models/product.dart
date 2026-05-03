import 'dart:typed_data';

class Product {
  final int? id;
  final String name;
  final String description;
  final Uint8List? imageData;
  final String status;
  final String qrData;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    this.description = "",
    this.imageData,
    required this.status,
    required this.qrData,
    this.createdBy,
    this.createdAt,
    this.updatedAt
    });

  bool get isActive => status == 'available';
  bool get isTaken => status == 'taken';
}
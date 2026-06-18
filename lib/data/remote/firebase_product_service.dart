import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monkey_shop/domain/models/product.dart';

class FirebaseProductService {
  final CollectionReference _productsRef = FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchAllProducts() async {
    final snapshot = await _productsRef.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      Uint8List? imageData;
      if(data['imageBase64'] != null ){
        imageData = base64Decode(data['imageBase64']);
      }

      return Product(
        id: data['localId'],
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        imageData: imageData,
        status: data['status'] ?? 'available',
        qrData: data['qrData'] ?? '',
        createdBy: data['createdBy'] ?? 1,
        createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
        updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      );
    }).toList();
  }

  Future<bool> productExists(int localProductId) async {
    final doc = await _productsRef.doc('product_$localProductId').get();
    return doc.exists;
  }

  Future<void> upsertProduct(Product product) async {
    final docId = 'product_${product.id}';

    final Map<String, dynamic> data = {
      'localId': product.id,
      'name': product.name,
      'description': product.description,
      'status': product.status,
      'qrData': product.qrData,
      'createdBy': product.createdBy,
      'createdAt': product.createdAt != null ? Timestamp.fromDate(product.createdAt!) : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if(product.imageData != null){
      data['imageBase64'] = base64Encode(product.imageData!);
    }

    await _productsRef.doc(docId).set(data, SetOptions(merge: true));
  }

  Future<void> deleteProduct(int productId) async {
    final docId = 'product_$productId';
    await _productsRef.doc(docId).delete();
  }
}
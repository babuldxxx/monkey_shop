import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({super.key, required this.product, this.onPressed});

  final Product product;
  final VoidCallback? onPressed;
  
  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity, 
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              product.pathImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(248, 222, 181, 158),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                product.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
                ),
                Text(
                  product.description,
                  style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
                )
              ]
            ),
          ),
        ],
      ),
    ),
  );
  }
}
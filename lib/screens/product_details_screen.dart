import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ProductDetailsScreen extends StatelessWidget {
const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context){
    return Scaffold(
    backgroundColor: const Color(0xFFFDF5E6),
    
    appBar: AppBar(
      title: Text(
        product.name,
        style: const TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 184, 165),
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.brown),
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
              image: DecorationImage(
                image: AssetImage(product.pathImage),
                fit: BoxFit.cover,
              ),
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
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: Colors.brown,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: const Icon(
                    //     Icons.camera_alt,
                    //     color: Color.fromARGB(248, 222, 181, 158),
                    //     size: 20,
                    //   ),
                    // ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        product.name,
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
                if (product.description.isNotEmpty) Text(
                  'Описание',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown[700],
                  ),
                ),
                
                const SizedBox(height: 8),
                if (product.description.isNotEmpty) Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.brown[800],
                  ),
                ),
                const SizedBox(height: 32),
                if(product.isActive == true) 
                const SizedBox(height: 8),
                PrettyQrView(qrImage: QrImage(
                  QrCode(8, QrErrorCorrectLevel.H)..addData(product.qrData)
                ), decoration: const PrettyQrDecoration()
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }
}
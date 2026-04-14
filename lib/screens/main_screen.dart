import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/product_details_screen.dart';
import 'package:flutter_application_1/screens/qr_scanner_screen.dart';
import '../models/product.dart';
import '../widgets/product_cart.dart';
import '../screens/add_product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final products = [
    Product(
      name: 'Punch`s mother',
      pathImage: 'assets/mom.jpg',
      description: 'Игрушечная мама Панча из Икеи.',
      qrData: 'Data 1'
    ),
    Product(
      name: 'Punch with mom ',
      pathImage: 'assets/punch_with_mom.jpg',
      description:
          'Панча бросила его настоящая мама. Теперь мамой он считает игрушку, в которой видит защиту',
      qrData: 'Data 1'
    ),
    Product(
      name: 'Punch is sad',
      pathImage: 'assets/punch is sad.jpg',
      description:
          'Панча обижают его сородичи, поэтому ему грустно и страшно. От врагов он прикрывается плюшевой мамой.',
      qrData: 'Data 1',
      isActive: true,
    ),
    Product(
      name: 'Punch with a new friend',
      pathImage: 'assets/punch witn friend.jpg',
      description: 'Панча приняла одна из обезьян и теперь он не одинок.',
      qrData: 'Data 1',
      isActive: true,
    ),
  ];

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 172, 160),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRScannerScreen(
                    products: products,
                  )
                )
              );
            },
            icon: const Icon(Icons.camera_alt_rounded),

          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
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
                    builder: (context) => ProductDetailsScreen(product: products[index]),
                  ),
                );
              },
              ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddProductScreen(),   
        )
      ).then((_){
        setState((){});
      });
    }, child: Icon(Icons.add),
    ),
    );
  }

}

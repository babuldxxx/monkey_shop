import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/widgets/text_field_app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({ super.key });

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var nameController = TextEditingController();
  var descController = TextEditingController();

  String? qrData;
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 200,
              color: Colors.grey,
              child: _imagePath != null ? Image.asset(
                _imagePath!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover
              ) : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate, size: 60, color: Colors.grey),
                    SizedBox(height: 8,),
                    Text("Нажмите для выбора фото")
                  ]
                )
              )
            )
          ),
          const SizedBox(height: 16,),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFieldApp(
                  controller: nameController, 
                  hintText: 'Введите название товара',
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8,),
          TextFieldApp(
            controller: descController, 
            hintText: 'Введите описание товара',
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),

          if(nameController.text.isNotEmpty)
            Builder(
              builder: (context) {
                qrData = nameController.text;
                return PrettyQrView(
                  qrImage: QrImage(QrCode(8, QrErrorCorrectLevel.H)..addData(qrData!)),
                  decoration: const PrettyQrDecoration(),
                );
              },
            )
            else const SizedBox.shrink(),

          ElevatedButton(
            onPressed: addProduct,
            child: Text('Добавить'),
          )
        ]
      )
    )
    );
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if(picked != null){
      setState((){
        _imagePath = picked.path;
      });
    }
  }

  void addProduct(){
    formKey.currentState!.validate();
    if(nameController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Поля введены неверно")));
      return;
    }

    final product = Product(
      name: nameController.text,
      pathImage: 'assets/mom.jpg',
      description: descController.text,
      qrData: qrData ?? nameController.text,
    );
    products.add(product);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Вы успешно создали товар!")));

  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/product.dart';
import 'package:flutter_application_1/providers/product_notifier.dart';
import 'package:flutter_application_1/widgets/text_field_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  var nameController = TextEditingController();
  var descController = TextEditingController();

  String? qrData;
  final ImagePicker _picker = ImagePicker();
  File? _fileImage;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _showImagePickerDialog(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _fileImage != null
                    ? Image.file(
                        _fileImage!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.add_a_photo, size: 50),
                      ),
              ),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 8),

            TextFieldApp(
              controller: descController,
              hintText: 'Введите описание товара',
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 12),

            if (nameController.text.isNotEmpty)
              Builder(
                builder: (context) {
                  qrData = nameController.text;
                  return PrettyQrView(
                    qrImage: QrImage(
                      QrCode(8, QrErrorCorrectLevel.H)..addData(qrData!),
                    ),
                    decoration: const PrettyQrDecoration(),
                  );
                },
              )
            else
              const SizedBox.shrink(),

            ElevatedButton(onPressed: addProduct, child: Text('Добавить')),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    var file = await _picker.pickImage(source: source);
    if (file != null) {
      setState(() {
        _fileImage = File(file.path);
      });
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выберите изображение'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Камера'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Галерея'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void addProduct() {
    if (formKey.currentState!.validate()) {
      return;
    }

    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Поля введены неверно")));
      return;
    }

    final product = Product(
      name: nameController.text,
      pathImage: _fileImage?.path ?? 'assets/default_product.png',
      description: descController.text,
      qrData: qrData ?? nameController.text,
    );

    ref.read(productProvider.notifier).addProduct(product);

    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Вы успешно создали товар!")));
  }
}

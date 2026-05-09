import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:monkey_shop/domain/models/product.dart';
import 'package:monkey_shop/providers/auth_notifier.dart';
import 'package:monkey_shop/providers/product_notifier.dart';
import 'package:monkey_shop/widgets/text_field_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key, this.product});

  final Product? product;

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late String qrData;

  final formKey = GlobalKey<FormState>();

  Uint8List? imageData;
  bool isLoading = false;
  bool isActive = true;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product?.name ?? '');
    descController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    qrData = widget.product?.qrData ?? '';
    imageData = widget.product?.imageData;
    isActive = widget.product?.status == 'available';
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        imageData = bytes;
      });
    }
  }

  Future<void> _saveProduct() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final authState = ref.read(authProvider);
      final currentUser = authState.value;

      final product = Product(
        id: widget.product?.id,
        name: nameController.text,
        description: descController.text,
        imageData: imageData,
        status: isActive ? 'available' : 'taken',
        qrData: qrData,
        createdBy: widget.product?.createdBy ?? currentUser?.id ?? 1,
        createdAt: widget.product?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final productNotifier = ref.read(productProvider.notifier);

      if (widget.product == null) {
        await productNotifier.addProduct(product);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Товар успешно добавлен'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else{
        await productNotifier.updateProduct(product);
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Товар успешно обновлен'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }

      if(mounted){
        Navigator.pop(context);
      }
    } catch (error) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally{
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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

  /*void addProduct() async {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пожалуйста, заполните все поля")),
      );
      return;
    }

    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Поля введены неверно")));
      return;
    }

    try {
      Uint8List? imageBytes;
      if (_fileImage != null) {
        imageBytes = await _fileImage!.readAsBytes();
      }

      final product = Product(
        name: nameController.text,
        imageData: imageBytes,
        // выяснить
        description: descController.text,
        qrData: qrData ?? nameController.text,
        status: 'Занят',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ref.read(productProvider.notifier).addProduct(product);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Вы успешно добавили товар!")));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка добавления товара $error")),
        );
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Редактировать товар' :'Добавить товар',
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
      body: isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _showImagePickerDialog(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imageData != null
                    ? Image.memory(
                        imageData!,
                        width: double.infinity,
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
                      QrCode(8, QrErrorCorrectLevel.H)..addData(qrData),
                    ),
                    decoration: const PrettyQrDecoration(),
                  );
                },
              )
            else
              const SizedBox.shrink(),

            ElevatedButton(onPressed: _saveProduct, child: Text(isEditing ? 'Добавить' : 'Изменить')),
          ],
        ),
      ),
    );
  }
}

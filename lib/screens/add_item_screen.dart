import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/model/item.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/widget/addItem/add_item_textfield.dart';
import 'package:storekeeperapp/widget/addItem/image_picker_listtile.dart';
import 'package:storekeeperapp/widget/addItem/take_photo_box.dart';

class UrgentAddItemScreen extends StatefulWidget {
  const UrgentAddItemScreen({super.key});

  @override
  State<UrgentAddItemScreen> createState() => _UrgentAddItemScreenState();
}

class _UrgentAddItemScreenState extends State<UrgentAddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final List<File> _images = [];

  Future<void> _pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    Navigator.pop(context);
    final List<XFile>? picked = await picker.pickMultiImage(imageQuality: 90);
    if (picked != null) {
      setState(() {
        if (_images.length < 5) {
          _images.addAll(
            picked.take(5 - _images.length).map((e) => File(e.path)),
          );
        }
      });
    }
  }

  Future<void> _pickFromcamera() async {
    final ImagePicker picker = ImagePicker();
    Navigator.pop(context);
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        if (_images.length < 5) _images.add(File(photo.path));
      });
    }
  }

//picking images screen
  Future<void> _pickImage() async {
    
  //displays the way you want to pick your pictures
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ImagePickerListtile(
              onTap: _pickFromcamera,
              icon: Icons.camera_alt,
              text: 'Take a photo',
            ),
            ImagePickerListtile(
              onTap: _pickFromGallery,
              icon: Icons.photo_library,
              text: 'Choose from gallery',
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveItem() async {
    final name = _nameController.text.trim();
    final qty = int.tryParse(_qtyController.text) ?? 1;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a product name')),
      );
      return;
    }

    final imagePath = _images.isNotEmpty ? _images.first.path : null;

    final newItem = Item(
      name: name,
      quantity: qty,
      price: price,
      imagePath: imagePath,
      createdAt: DateTime.now(),
    );

    await context.read<ItemProvider>().addItem(newItem);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        title: const Text(
          'Add New Product',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TakePhotoBox(
              onPickImage: _pickImage,
              images: _images,
            ),
            const SizedBox(height: 20),

            const Text('PRODUCT NAME',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            AddItemTextfield(controller: _nameController, hint: 'Add Product', keyboardType: TextInputType.text,),
            const SizedBox(height: 16),

            const Text('PRICE', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('NGN'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: AddItemTextfield(
                    controller: _priceController,
                    hint: 'price',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('QUANTITY',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            AddItemTextfield(controller: _qtyController, hint: 'Quantity', keyboardType: TextInputType.number,),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _saveItem, //  Now connected
                child: const Text(
                  'UPLOAD',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
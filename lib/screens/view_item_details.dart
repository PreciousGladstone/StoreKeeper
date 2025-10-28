import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/model/item.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/widget/viewitemwidget/product_text_heading.dart';
import 'package:storekeeperapp/widget/viewitemwidget/viewimage.dart';

class ViewItemScreen extends StatefulWidget {
  const ViewItemScreen({super.key, required this.item});

  final Item item;

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  String? _newImagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _priceController = TextEditingController(
      text: widget.item.price.toString(),
    );
    _quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    _newImagePath = widget.item.imagePath;
  }

  //dispose the controller
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _toggleEdit() => setState(() => _isEditing = !_isEditing);

  //could edit images and pick with this logic
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _newImagePath = picked.path);
    }
  }

  // save changes to you copy with from at your model class
  Future<void> _saveChanges() async {
    final updatedItem = widget.item.copyWith(
      name: _nameController.text.trim(),
      price: double.tryParse(_priceController.text) ?? widget.item.price,
      quantity: int.tryParse(_quantityController.text) ?? widget.item.quantity,
      imagePath: _newImagePath,
    );

    await context.read<ItemProvider>().updateItem(updatedItem);
    setState(() => _isEditing = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Item updated successfully')));
  }

  // you could delete both from your view screen and your add items
  Future<void> _deleteItem() async {
    await context.read<ItemProvider>().deleteItem(widget.item);
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),

        //action buttons that will call the provider to perform this CRUD operations
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: _deleteItem,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image (Editable)
            Viewimage(
              isEditing: _isEditing,
              pickImage: _pickImage,
              newImagePath: _newImagePath,
            ),

            const SizedBox(height: 20),

            // 🧾 Product Details
            ProductTextHeading(name: 'Product Name'),
            _isEditing
                ? TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter product name',
                    ),
                  )
                : Text(
                    widget.item.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
            const SizedBox(height: 12),

            ProductTextHeading(name: 'Price'),
            _isEditing
                ? TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      hintText: 'Enter price (₦)',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  )
                : Text(
                    '₦${widget.item.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
            const SizedBox(height: 12),

            ProductTextHeading(name: 'Quantity'),
            _isEditing
                ? TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      hintText: 'Enter quantity',
                    ),
                    keyboardType: TextInputType.number,
                  )
                : Text(
                    '${widget.item.quantity}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
            const SizedBox(height: 16),

            Spacer(),
            Center(
              child: Text(
                'Date Added: ${widget.item.createdAt?.toLocal().toString().split(' ')[0] ?? 'Unknown'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

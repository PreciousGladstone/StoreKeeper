// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'package:provider/provider.dart';
// import 'package:storekeeperapp/model/item.dart';
// import 'package:storekeeperapp/provider/item_provider.dart';

// class AddItemScreen extends StatefulWidget {
//   const AddItemScreen({super.key});

//   @override
//   State<AddItemScreen> createState() => _AddItemScreenState();
// }

// class _AddItemScreenState extends State<AddItemScreen> {
//   final _name = TextEditingController();
//   final _qty = TextEditingController();
//   final _price = TextEditingController();

//   //holding the saved photopath
//   String? _photoPath;

//   // logic for. get image through the imagepicker after snapping
//   Future<void> _takePhoto() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(
//       source: ImageSource.camera,
//       imageQuality: 100,
//     );
//     if (picked == null) return;
//     final appDoc = await getApplicationDocumentsDirectory();
//     final fileName =
//         'item_${DateTime.now().microsecondsSinceEpoch}${p.extension(picked.path)}';
//     final saved = await File(picked.path).copy(p.join(appDoc.path, fileName));
//     setState(() {
//       _photoPath = saved.path;
//     });
//   }

//   Future<void> _save() async {
//     final name = _name.text.trim();
//     if (name.isEmpty) return;
//     final qty = int.tryParse(_qty.text) ?? 1;
//     final price = double.tryParse(_price.text) ?? 0.0;
    
//     final item = Item(
//       name: name,
//       quantity: qty,
//       price: price,
//       imagePath: _photoPath,
//       createdAt: DateTime.now(),
//     );

//     await context.read<ItemProvider>().addItem(item);

//     if (mounted) Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         title: Text('Add Item'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _name,
//               decoration: InputDecoration(labelText: 'Product Name'),
//             ),
//             TextField(
//               controller: _qty,
//               decoration: InputDecoration(labelText: 'Qty', labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
//                 color: Theme.of(context).hintColor
//               )),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: _price,
//               decoration: InputDecoration(labelText: 'Price'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 8),
//             if (_photoPath != null) Image.file(File(_photoPath!), height: 150),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: _takePhoto,
//                   child: Icon(Icons.camera),
//                 ),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: _save,
//                   child: Text('Save', style: TextStyle()),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

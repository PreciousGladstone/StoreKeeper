import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/model/item.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/screens/urgent_add_item_screen.dart'; // For editing (reuse the same screen)

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.title,
    required this.qty,
    required this.price,
    required this.item,
  });

  final String title;
  final String qty;
  final String price;
  final Item item;

  Color getAvatarColor(String name) {
    final colors = [
      Colors.blue.shade400,
      Colors.green.shade400,
      Colors.purple.shade400,
      Colors.orange.shade400,
      Colors.red.shade400,
      Colors.teal.shade400,
    ];
    return colors[name.isNotEmpty ? name.codeUnitAt(0) % colors.length : 0];
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id.toString()), // unique key required
      direction: DismissDirection.endToStart, // swipe left to delete
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (direction) async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete Item'),
            content: Text('Are you sure you want to delete "${item.name}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        return confirm ?? false;
      },
      onDismissed: (direction) async {
        await context.read<ItemProvider>().deleteItem(item);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.name} deleted')),
        );
      },
      child: InkWell(
        onTap: () {
          // Navigate to edit screen (reuse add item screen)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UrgentAddItemScreen(), //  Pass the item for editing
            ),
          );
        },
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          child: ListTile(
            leading: item.imagePath != null && item.imagePath!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(item.imagePath!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundColor: getAvatarColor(item.name),
                    child: Text(
                      item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Text(
                    'Qty: $qty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '₦$price',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
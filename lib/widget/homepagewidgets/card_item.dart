import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/model/item.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/screens/view_item_details.dart'; // For editing (reuse the same screen)

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

    Future<void> update() async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => ViewItemScreen(item: item)),
      );

      await context.read<ItemProvider>().loadItem();
    }
    return InkWell(
      onTap: update,
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
          subtitle: Text(
          "Qty: ${item.quantity}  |  Price: ₦${item.price.toStringAsFixed(2)}",
          style: TextStyle(),
        ),
        ),
      ),
    );
  }
}

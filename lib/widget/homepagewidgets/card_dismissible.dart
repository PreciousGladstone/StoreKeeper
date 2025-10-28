import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/model/item.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/widget/homepagewidgets/card_item.dart';

class CardDismissible extends StatelessWidget {
  const CardDismissible({
    super.key,
    required this.item,
    required this.title,
    required this.qty,
    required this.price,
  });

  final String title;
  final String qty;
  final String price;
  final Item item;

  @override
  Widget build(BuildContext context) {
    //this is handles the dismissable widget, handles it perfectly
    return Dismissible(
      key: Key(item.id.toString()), // unique key required
      direction: DismissDirection.endToStart, // swipe left to delete
      background: Container(
        color: const Color.fromARGB(255, 154, 105, 105),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onTertiary,
                ),
                child: const Text('Cancel'),
              ),
              Spacer(),
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
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${item.name} deleted',
              // ignore: use_build_context_synchronously
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                // ignore: use_build_context_synchronously
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
      child: CardItem(title: title, qty: qty, price: price, item: item),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:storekeeperapp/model/item.dart';

class StockTile extends StatelessWidget {
  const StockTile({super.key, required this.item, required this.color});

  final Item item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.inventory, color: color),
        title: Text(item.name),
        subtitle: Text(
          "Qty: ${item.quantity}  |  Price: ₦${item.price.toStringAsFixed(2)}",
          style: TextStyle(),
        ),
        trailing: Text(
          item.quantity < 10 ? "Low" : "High",
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

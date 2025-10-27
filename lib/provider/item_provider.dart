import 'package:flutter/material.dart';
import 'package:storekeeperapp/model/item.dart';
import 'package:storekeeperapp/services/db_service.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> _item = [];
  List<Item> _filteredItem = [];

  List<Item> get item => _filteredItem.isEmpty ? _item : _filteredItem;

  Future<void> loadItem() async {
    _item = await DBService.instance.getItem();
    notifyListeners();
  }

  Future<void> addItem(Item item) async {
    await DBService.instance.createItem(item);
    await loadItem();
  }

  Future<void> deleteItem(Item item) async {
    if (item.id != null) await DBService.instance.deleteItem(item.id!);
    await loadItem();
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      _filteredItem = [];
    } else {
      _filteredItem = item
          .where(
            (item) => item.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  //get the total number of producct 
  int get totalProduct => _item.length;
  //get the total number of Quantities
  int get totalQuantity => _item.fold(0, (sum, item) => sum + (item.quantity) );

  //get the price of the items 
  double get totalPrice => _item.fold(0, (sum, item) => sum + (item.price * item.quantity));

  // Helper to format large numbers (1000 → 1K, 1000000 → 1M, etc.)
  String _formatNumber(double number) {
    String format(double n) {
      final s = n.toStringAsFixed(1);
      return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
    }

    if (number >= 1000000000) {
      return '${format(number / 1000000000)}B';
    } else if (number >= 1000000) {
      return '${format(number / 1000000)}M';
    } else if (number >= 1000) {
      return '${format(number / 1000)}K';
    } else {
      return number.toStringAsFixed(0);
    }
  }

  // Get formatted values directly
  String get formattedTotalPrice => _formatNumber(totalPrice);
  String get formattedTotalQuantity => _formatNumber(totalQuantity.toDouble());
  String get formattedTotalProduct => _formatNumber(totalProduct.toDouble());

}

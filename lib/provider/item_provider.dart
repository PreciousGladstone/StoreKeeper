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
}

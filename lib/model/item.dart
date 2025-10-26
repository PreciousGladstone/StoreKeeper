class Item {
  Item({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.imagePath,
    this.createdAt,
  });

  int? id;
  String name;
  int quantity;
  double price;
  String? imagePath;
  DateTime? createdAt;
}

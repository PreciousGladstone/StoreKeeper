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

  Item copyWith({
    int? id,
    String? name,
    int? quantity,
    double? price,
    String? imagePath,
    DateTime? createdAt,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

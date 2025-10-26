import 'package:storekeeperapp/model/item.dart';

class ItemMapper {
  //convert a map from DB to an Item object
  static Item fromMap(Map<String, dynamic> map){
    return Item(
      id: map['id'] is int? map['id'] as int: null,
      name: (map['name']?? ''),
      quantity: (map['quantity']?? 0) as int,
      price: (map['price'] ?? 0).toDouble(),
      imagePath: map['imagePath'],
      createdAt: map['createdAt'] !=null? (DateTime.fromMillisecondsSinceEpoch(map['createdAt'])): null,
    );
  }


  // convert an item object to a map
  static Map<String, dynamic> toMap(Item item){
    return {
      'id' : item.id,
      'name': item.name,
      'quantity': item.quantity,
      'price' : item.price,
      'imagePath': item.imagePath,
      'createdAt': item.createdAt?.millisecondsSinceEpoch,
    };
  }
}


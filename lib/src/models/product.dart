import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/src/models/item_size.dart';

class Product {
  Product.fromDocument(DocumentSnapshot document) {
    if (document.exists) {
      try {
        id = document.id;
        name = document['name'] as String;
        description = document['description'] as String;
        images = List<String>.from(document['images'] as List<dynamic>);
        sizes = (document['sizes'] as List<dynamic>)
            .map((size) => ItemSize.fromMap(size as Map<String, dynamic>))
            .toList();
      } catch (e) {}
    }
  }

  late String id;
  late String name;
  late String description;
  late List<String> images;
  List<ItemSize> sizes = [];
}

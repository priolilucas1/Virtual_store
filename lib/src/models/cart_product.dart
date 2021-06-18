import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/src/models/item_size.dart';
import 'package:loja_virtual/src/models/product.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize!.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    productId = document['pid'] as String;
    quantity = document['quantity'] as int;
    size = document['size'] as String;

    firestore
        .doc('products/$productId')
        .get()
        .then((doc) => product = Product.fromDocument(doc));
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late Product product;

  late String productId;
  late int quantity;
  late String size;

  ItemSize get itemSize {
    return product.findSize(size);
  }

  num get unitPrice {
    return itemSize.price;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }
}

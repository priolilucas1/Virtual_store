import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:loja_virtual/src/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> _allProducts = [];

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();

    _allProducts =
        snapProducts.docs.map((doc) => Product.fromDocument(doc)).toList();

    notifyListeners();
  }
}

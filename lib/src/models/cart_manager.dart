import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:loja_virtual/src/models/cart_product.dart';
import 'package:loja_virtual/src/models/product.dart';
import 'package:loja_virtual/src/models/user.dart';
import 'package:loja_virtual/src/models/user_manager.dart';

class CartManager {
  List<CartProduct> items = [];

  User? user;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    } else {}
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user!.cartReference.get();

    items = cartSnap.docs
        .map((product) => CartProduct.fromDocument(product))
        .toList();
  }

  void addToCart(Product product) {
    final cartProduct = CartProduct.fromProduct(product);

    items.add(cartProduct);
    user!.cartReference.add(cartProduct.toCartItemMap());
  }
}

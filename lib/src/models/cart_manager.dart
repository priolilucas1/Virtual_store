import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:loja_virtual/src/models/cart_product.dart';
import 'package:loja_virtual/src/models/product.dart';
import 'package:loja_virtual/src/models/user.dart';
import 'package:loja_virtual/src/models/user_manager.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  User? user;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user!.cartReference.get();

    items = cartSnap.docs
        .map((product) =>
            CartProduct.fromDocument(product)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    try {
      final entity = items.firstWhere((p) => p.stackable(product));
      entity.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);

      items.add(cartProduct);
      user!.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
    }

    notifyListeners();
  }

  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere((product) => product.id == cartProduct.id);
    user!.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated() {
    for (final cartProduct in items) {
      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
      }
      _updateCartProduct(cartProduct);
    }
  }

  void _updateCartProduct(CartProduct cartProduct) {
    user!.cartReference.doc(cartProduct.id).update(cartProduct.toCartItemMap());
  }
}

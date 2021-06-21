import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:loja_virtual/src/models/cart_product.dart';
import 'package:loja_virtual/src/models/product.dart';
import 'package:loja_virtual/src/models/user.dart';
import 'package:loja_virtual/src/models/user_manager.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  User? user;

  num productsPrice = 0.0;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    productsPrice = 0.0;

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

  Future<void> addToCart(Product product) async {
    try {
      final entity = items.firstWhere((p) => p.stackable(product));
      entity.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);

      items.add(cartProduct);
      await user!.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);

      _onItemUpdated();
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
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }

    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      user!.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
    }
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }
}

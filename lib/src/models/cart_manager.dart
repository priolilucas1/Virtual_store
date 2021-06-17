import 'package:loja_virtual/src/models/cart_product.dart';
import 'package:loja_virtual/src/models/product.dart';

class CartManager {
  List<CartProduct> items = [];

  void addToCart(Product product) {
    items.add(CartProduct.fromProduct(product));
  }
}

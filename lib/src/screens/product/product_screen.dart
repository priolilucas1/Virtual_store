import 'package:flutter/material.dart';
import 'package:loja_virtual/src/models/cart_manager.dart';
import 'package:loja_virtual/src/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:loja_virtual/src/models/product.dart';

import 'components/size_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                aspectRatio: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 15),
              ),
              items: product.images.map((url) {
                return Builder(builder: (BuildContext context) {
                  return Image(
                    image: NetworkImage(url),
                  );
                });
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Text(
                    'R\$ 19.99',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descri????o',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((size) {
                      return SizeWidget(size);
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                        builder: (_, userManager, product, __) {
                      return SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: product.selectedSize != null
                              ? () {
                                  if (userManager.isLoggedIn) {
                                    context
                                        .read<CartManager>()
                                        .addToCart(product);
                                    Navigator.of(context).pushNamed('/cart');
                                  } else {
                                    Navigator.of(context).pushNamed('/login');
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              onSurface: primaryColor, onPrimary: Colors.white),
                          child: Text(
                            userManager.isLoggedIn
                                ? 'Adicionar ao carrinho'
                                : 'Entre para comprar',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

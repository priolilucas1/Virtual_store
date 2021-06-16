import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_virtual/src/models/product_manager.dart';
import 'package:loja_virtual/src/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/src/screens/products/components/search_dialog.dart';
import 'package:loja_virtual/src/screens/products/components/product_list_tile.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isNotEmpty) {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(productManager.search),
                    );

                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  child: SizedBox(
                    width: constraints.biggest.width,
                    child: Text(
                      productManager.search,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              });
            } else {
              return const Text('Produtos');
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  onPressed: () async {
                    final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(productManager.search),
                    );

                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  icon: const Icon(Icons.search),
                );
              } else {
                return IconButton(
                  onPressed: () async {
                    productManager.search = '';
                  },
                  icon: const Icon(Icons.close),
                );
              }
            },
          ),
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(filteredProducts[index]);
            },
          );
        },
      ),
    );
  }
}

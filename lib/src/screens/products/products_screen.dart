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
        title: const Text('Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final search = await showDialog<String>(
                context: context,
                builder: (_) => SearchDialog(),
              );

              if (search != null) {
                context.read<ProductManager>().search = search;
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
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

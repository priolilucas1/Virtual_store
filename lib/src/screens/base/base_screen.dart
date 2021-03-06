import 'package:flutter/material.dart';

import 'package:loja_virtual/src/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/src/models/page_manager.dart';
import 'package:loja_virtual/src/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
              centerTitle: true,
            ),
          ),
          ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home3'),
              centerTitle: true,
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home4'),
              centerTitle: true,
            ),
          ),
        ],
      ),
    );
  }
}

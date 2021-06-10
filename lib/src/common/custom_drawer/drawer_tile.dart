import 'package:flutter/material.dart';
import 'package:loja_virtual/src/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {required this.iconData, required this.title, required this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            child: Icon(
              iconData,
              size: 32,
              color: curPage == page ? primaryColor : Colors.grey[700],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: curPage == page ? primaryColor : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

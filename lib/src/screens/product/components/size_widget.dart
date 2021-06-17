import 'package:flutter/material.dart';
import 'package:loja_virtual/src/models/item_size.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget(this.size);

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.grey,
        ),
      ),
      child: Row(
        children: [
          Container(
            color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              size.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

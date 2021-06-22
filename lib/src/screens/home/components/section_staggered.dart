import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual/src/models/section.dart';
import 'package:loja_virtual/src/screens/home/components/item_tile.dart';
import 'package:loja_virtual/src/screens/home/components/section_header.dart';

class SectionStaggered extends StatelessWidget {
  final Section section;

  const SectionStaggered(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: section.items.length,
            itemBuilder: (_, index) {
              return ItemTile(section.items[index]);
            },
            staggeredTileBuilder: (index) => StaggeredTile.count(
              index.isEven ? 2 : 2,
              index.isEven ? 2.8 : 1.3,
            ),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
        ],
      ),
    );
  }
}

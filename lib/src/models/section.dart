import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/src/models/section_item.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document)
      : name = document['name'] as String,
        type = document['type'] as String,
        items = (document['items'] as List)
            .map((item) => SectionItem.fromMap(item as Map<String, dynamic>))
            .toList();

  final String name;
  final String type;
  final List<SectionItem> items;
}

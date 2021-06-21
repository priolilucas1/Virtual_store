import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/src/helpers/firebase_errors.dart';
import 'package:loja_virtual/src/models/section_item.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document) {
    try {
      if (document.exists) {
        name = document['name'] as String;
        type = document['type'] as String;
        items = (document['items'] as List)
            .map((item) => SectionItem.fromMap(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      getErrorString(e.toString());
    }
  }

  late String name;
  late String type;
  late List<SectionItem> items;
}

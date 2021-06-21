class ItemSize {
  ItemSize.fromMap(Map<String, dynamic> map)
      : name = map['name'] as String,
        price = map['price'] as num,
        stock = map['stock'] as int;

  final String name;
  final num price;
  final int stock;

  bool get hasStock => stock > 0;
}

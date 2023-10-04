import 'dart:ui';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.color,
    this.docId
  });

  String? docId;
  String id;
  String name;
  Color color;
}

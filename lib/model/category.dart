import 'dart:ui';

class Category {
  const Category({
    required this.id,
    required this.name,
    required this.color,
    this.docId
  });

  final String? docId;
  final String id;
  final String name;
  final Color color;
}

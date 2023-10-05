import 'dart:ui';

import 'package:flutter/material.dart';

class Category {
  Category({
    required this.id,
    required this.name,
    this.color = Colors.green,
    this.docId,
  });

  String? docId;
  String id;
  String name;
  Color color;

  Category.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        color = Colors.green;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

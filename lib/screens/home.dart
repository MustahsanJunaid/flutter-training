import 'package:flutter/material.dart';
import 'package:training/components/category_grid_item.dart';
import 'package:training/data/dummy_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Categories"),
        //backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GridView(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5/3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [for (final category in plantCategories) CategoryGridItem(category)],
      ),
    );
  }
}

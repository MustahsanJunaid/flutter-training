import 'package:flutter/material.dart';
import 'package:training/model/category.dart';

typedef ItemTap = Function(Category category);

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(this.category, {super.key, this.onItem});

  final Category category;
  final ItemTap? onItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItem?.call(category);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16.0),
      child: Hero(
        tag: category.id,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.40),
                category.color.withOpacity(0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            category.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/components/category_grid_item.dart';
import 'package:training/model/category.dart';
import 'package:training/providers/category_provider.dart';
import 'package:training/providers/selected_category_notifier.dart';
import 'package:training/screens/home/screen_breakpoints.dart';
import '../../di/locator.dart';
import '../../navigation/navigation_service.dart';

final NavigationService navService = locator<NavigationService>();

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isLoading = true;

  @override
  void initState() {
    ref.read(categoryListProvider.notifier).fetchData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoryListProvider);

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        child: GridView.builder(
          itemCount: categories.length,
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ScreenBreakPoints.isTablet(context) ? 1 : 2,
            childAspectRatio: 5 / 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) => CategoryGridItem(
            categories[index],
            onItem: (item) => ref.read(selectedCategoryProvider.notifier).selectCategory(item.id),
          ),
        ),
        builder: (context, child) => Padding(
          padding: EdgeInsets.only(top: 200 - _animationController.value * 200),
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  final void Function(int) onItemTap;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final item in items.indexed)
          DrawerListItem(
            title: item.$2,
            onTap: () {
              onItemTap(item.$1);
            },
          )
      ],
    );
  }
}

class DrawerList2 extends StatelessWidget {
  const DrawerList2({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  final void Function(int) onItemTap;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return DrawerListItem(
            title: items[index],
            onTap: () {
              onItemTap(index);
            });
      },
    );
  }
}

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navService.pop();
        onTap();
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w500),
          )),
    );
  }
}

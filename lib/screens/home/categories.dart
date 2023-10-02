import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/components/category_grid_item.dart';
import 'package:training/dialog/dialog_util.dart';
import 'package:training/model/category.dart';
import '../../di/locator.dart';
import '../../navigation/navigation_service.dart';
import '../../navigation/routes.dart';

final NavigationService navService = locator<NavigationService>();

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GridView.builder(
        itemCount: categories.length,
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 200,
          childAspectRatio: 5 / 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) => CategoryGridItem(
          categories[index],
          onItem: (item) => {
            navService.navigateTo(Routes.updateCategory, arguments: item),
          },
        ),
      ),
    );
  }

  void fetchCategories() async {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference categoryRef = FirebaseFirestore.instance.collection('categories-${user.uid}');
    categoryRef.snapshots().listen((event) {
      categories.clear();
      setState(() {
        categories.addAll(event.docs
            .map((e) => Category(docId: e.id, id: e.get("id"), name: e.get("name"), color: Colors.green))
            .toList());
      });
    }, onError: (error) {
      print("Failed fetching categories");
    });

    // navService.goBack();

    // categoryRef.get()
    //     .then((value) {
    //   print("User Added");
    //   navService.goBack();
    //   DialogUtil.showSnackBar(context, "Category created successfully");
    // })
    //     .catchError((error) {
    //   print("Failed to add user: $error");
    //   navService.goBack();
    // });
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

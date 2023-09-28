import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/components/category_grid_item.dart';
import 'package:training/data/dummy_data.dart';
import 'package:training/dialog/dialog_util.dart';
import 'package:training/model/category.dart';

import '../di/locator.dart';
import '../navigation/navigation_service.dart';
import '../navigation/routes.dart';

final NavigationService navService = locator<NavigationService>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.email});

  final String? email;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final drawerItems = ["Profile", "Home", "Settings", "Sign out"];

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
      appBar: AppBar(
        title: const Text("Plant Categories"),
        actions: [IconButton(onPressed: () => signOut(context), icon: const Icon(Icons.logout))],
        //backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        child: DrawerList2(
            items: drawerItems,
            onItemTap: (position) {
              onDrawerItemTap(context, position);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => navService.navigateTo(Routes.createCategory),
        child: const Icon(Icons.add),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5 / 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [for (final category in categories) CategoryGridItem(category)],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    if (isLoading) {
      DialogUtil.showLoading(context, content: 'Fetching data...');
    } else {
      navService.goBack();
    }
    super.didUpdateWidget(oldWidget);
  }

  void onDrawerItemTap(BuildContext context, int itemIndex) {
    switch (drawerItems[itemIndex]) {
      case "Profile":
        navService.navigateTo(Routes.profile);
      case "Sign out":
        signOut(context);
    }
  }

  void signOut(BuildContext context) async {
    DialogUtil.showLoading(context, content: 'Signing out..');
    await FirebaseAuth.instance.signOut();
    navService.replaceToByClearingStack(Routes.login);
  }

  void fetchCategories() async {
    // DialogUtil.showLoading(context, content: 'Fetching Category');
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference categoryRef = FirebaseFirestore.instance.collection('categories-${user.uid}');
    var snapshot = await categoryRef.get();

    setState(() {
      isLoading = false;
      categories.clear();
      for (var element in snapshot.docs) {
        print("TESTNG FIRESTORE: ${element.data()}");
        final category = Category(id: element.id, name: element.get("name"), color: Colors.green);
        categories.add(category);
      }
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
        navService.goBack();
        onTap();
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )),
    );
  }
}

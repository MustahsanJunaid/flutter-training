import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/model/category.dart';
import 'package:training/providers/selected_category_notifier.dart';
import 'package:training/screens/category_details_screen.dart';
import 'package:training/screens/home/screen_breakpoints.dart';

import '../../dialog/dialog_util.dart';
import '../../navigation/routes.dart';
import 'categories.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<String> _drawerItems = [];

  @override
  Widget build(BuildContext context) {
    _drawerItems = [
      "Profile",
      "Home",
      "Settings",
      "${AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? "Dark" : "Light"} Theme",
      "Sign out",
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plantation'),
        actions: [IconButton(onPressed: () => signOut(context), icon: const Icon(Icons.logout))],
      ),
      drawer: Drawer(
        child: DrawerList2(
            items: _drawerItems,
            onItemTap: (position) {
              onDrawerItemTap(context, position);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => navService.navigateTo(Routes.createCategory),
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > ScreenBreakPoints.tablet) {
          return const WideWidget();
        } else {
          return const NarrowWidget();
        }
      }),
    );
  }

  void signOut(BuildContext context) async {
    DialogUtil.showLoading(context, content: 'Signing out..');
    await FirebaseAuth.instance.signOut();
    navService.replaceToByClearingStack(Routes.login);
  }

  void onDrawerItemTap(BuildContext context, int itemIndex) {
    switch (_drawerItems[itemIndex]) {
      case "Profile":
        navService.navigateTo(Routes.profile);
      case "Light Theme":
        AdaptiveTheme.of(context).setLight();
      case "Dark Theme":
        AdaptiveTheme.of(context).setDark();
      case "Sign out":
        signOut(context);
    }
  }
}

class WideWidget extends StatelessWidget {
  const WideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("Build of Home is called");
    return const Row(
      children: [
        SizedBox(
          width: 250,
          child: CategoryScreen(),
        ),
        Expanded(
          child: CategoryDetailsScreen(
            showAppBar: false,
          ),
        ),
      ],
    );
  }
}

class NarrowWidget extends ConsumerWidget {
  const NarrowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Category? category = ref.watch(selectedCategoryProvider);
    if(category!=null){
      navService.navigateTo(Routes.categoryDetails);
    }
    return const CategoryScreen();
  }
}

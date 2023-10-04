import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/model/category.dart';

class CategoryListNotifier extends StateNotifier<List<Category>> {
  // CategoryListNotifier(super.state);
  CategoryListNotifier() : super([]);

  void fetchData() {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference categoryRef = FirebaseFirestore.instance.collection('categories-${user.uid}');
    List<Category> categories = [];
    categoryRef.get().then((value) {
      for (var doc in value.docs) {
        categories.add(Category(docId: doc.id, id: doc.get("id"), name: doc.get("name"), color: Colors.green));
      }
      state = categories;
    });
    // categoryRef.snapshots().listen((event) {
    //   List<Category> categories = [];
    //   categories.addAll(event.docs
    //       .map((e) => Category(docId: e.id, id: e.get("id"), name: e.get("name"), color: Colors.green))
    //       .toList());
    //   state = categories;
    // }, onError: (error) {
    //   print("Failed fetching categories");
    // });
  }

  void updateCategory(Category category) {
    Category? cat = state.firstWhere((element) => element.id == category.id);
    final index = state.indexOf(cat);
    if (index >= 0) {
      final copy = List.of(state);
      copy[index].name = category.name;
      state = copy;
    }
  }
}

var categoryListProvider = StateNotifierProvider<CategoryListNotifier, List<Category>>((ref) => CategoryListNotifier());

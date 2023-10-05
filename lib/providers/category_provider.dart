import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryListNotifier extends StateNotifier<List<Category>> {
  // CategoryListNotifier(super.state);
  CategoryListNotifier() : super([]);

  final url = Uri.https(
    "flutter-training-efce7-default-rtdb.firebaseio.com",
    '${FirebaseAuth.instance.currentUser?.uid}-categories.json',
  );

  void fetchData() async {
    final response = await http.get(url, headers: {'Content-Type': "application/Json"});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<Category> categories = [];
      for (final item in data.entries) {
        categories.add(Category(id: item.value['id'] as String, name: item.value['name'], docId: item.key));
      }
      state = categories;
    }
  }

  // void fetchData() {
  //   final user = FirebaseAuth.instance.currentUser!;
  //   CollectionReference categoryRef = FirebaseFirestore.instance.collection('categories-${user.uid}');
  //   List<Category> categories = [];
  //   categoryRef.get().then((value) {
  //     for (var doc in value.docs) {
  //       categories.add(Category(docId: doc.id, id: doc.get("id"), name: doc.get("name"), color: Colors.green));
  //     }
  //     state = categories;
  //   });
  // }

  void updateCategory(Category category) {
    Category? cat = state.firstWhere((element) => element.id == category.id);
    final index = state.indexOf(cat);
    if (index >= 0) {
      final copy = List.of(state);
      copy[index].name = category.name;
      state = copy;
    }
  }

  void append(Category category) {
    state = [category, ...state];
  }
}

var categoryListProvider = StateNotifierProvider<CategoryListNotifier, List<Category>>((ref) => CategoryListNotifier());

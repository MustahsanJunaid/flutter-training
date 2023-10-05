import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:training/network/result.dart';
import 'package:training/providers/category_provider.dart';

class CreateCategoryNotifier extends StateNotifier<Result?> {
  final StateNotifierProviderRef<CreateCategoryNotifier, Result?> ref;
  final url = Uri.https("flutter-training-efce7-default-rtdb.firebaseio.com",
      '${FirebaseAuth.instance.currentUser?.uid}-categories.json');

  CreateCategoryNotifier(this.ref) : super(null);

  void reset() => state = null;

  void create(Category category) {

      state = Result(state: Loading(true));
      http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(category)).then((response) {
        state = Result(state: Loading(false));
        if (response.statusCode == 200) {
          state = Result(state: Success(category));
          ref.read(categoryListProvider.notifier).append(category);
        } else {
          state = Result(state: Failure(Exception("Error")));
        }
      }).catchError((e){
        state = Result(state: Loading(false));
        state = Result(state: Failure(Exception(e.toString())));
        print("exception on API Calls ${e.toString()}");
      });
  }
  // void create(Category category) async {
  //   try {
  //     state = Result(state: Loading(true));
  //     var response = await http.post(url,
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //         body: category);
  //     state = Result(state: Loading(false));
  //     if (response.statusCode == 200) {
  //       state = Result(state: Success(category));
  //       ref.read(categoryListProvider.notifier).append(category);
  //     } else {
  //       state = Result(state: Failure(Exception("Error")));
  //     }
  //   } catch (e) {
  //     state = Result(state: Failure(Exception(e.toString())));
  //     print("exception on API Calls ${e.toString()}");
  //   }
  // }
}

var createCategoryListProvider =
    StateNotifierProvider<CreateCategoryNotifier, Result?>((ref) => CreateCategoryNotifier(ref));

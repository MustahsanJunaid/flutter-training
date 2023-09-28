import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training/dialog/dialog_util.dart';
import 'package:training/screens/home.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class CreateCategory extends StatelessWidget {
  CreateCategory({super.key});

  final nameController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Plant Categories"),
          //backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 46),
              MyTextField(
                controller: idController,
                hint: 'Category  Id',
              ),
              const SizedBox(height: 8),
              MyTextField(
                controller: nameController,
                hint: 'Category Name',
              ),
              const SizedBox(height: 8),
              MyButton(onTap: () => createCategory(context), text: 'Update',),
            ],
          ),
        ));
  }

  void createCategory(BuildContext context) async {
    DialogUtil.showLoading(context, content: 'Creating Category');
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference category = FirebaseFirestore.instance.collection('categories-${user.uid}');
    category
        .add({
      'name': nameController.text, // John Doe
      'id': idController.text
    })
        .then((value) {
      print("User Added");
      navService.goBack();
      DialogUtil.showSnackBar(context, "Category created successfully");
    })
        .catchError((error) {
      print("Failed to add user: $error");
      navService.goBack();
    });
  }
}

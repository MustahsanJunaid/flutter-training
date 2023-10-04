import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training/dialog/dialog_util.dart';
import 'package:training/model/category.dart';
import 'package:training/providers/selected_category_notifier.dart';
import 'package:training/screens/home/categories.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class UpdateCategory extends ConsumerWidget {
  UpdateCategory({super.key, this.existingCategory});

  final Category? existingCategory;

  final nameController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    nameController.text = existingCategory?.name ?? "";
    idController.text = existingCategory?.id ?? "";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Category"),
          //backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              MyTextField(
                textInputAction: TextInputAction.next,
                controller: idController,
                hint: 'Category Id',
              ),
              const SizedBox(height: 12),
              MyTextField(
                textInputAction: TextInputAction.done,
                controller: nameController,
                hint: 'Category Name',
                onSubmitted: (value) => onSubmit(context, ref),
              ),
              const SizedBox(height: 36),
              MyButton(
                onTap: () => onSubmit(context, ref),
                text: "Update",
              ),
              const SizedBox(height: 36),
            ],
          ),
        ));
  }

  void onSubmit(BuildContext context, WidgetRef ref) => updateCategory(context, existingCategory!.docId!, ref);

  void updateCategory(BuildContext context, String catId, WidgetRef ref) async {
    DialogUtil.showLoading(context, content: 'Updating Category');
    final user = FirebaseAuth.instance.currentUser!;
    DocumentReference category = FirebaseFirestore.instance.collection('categories-${user.uid}').doc(catId);
    category.set({
      'name': nameController.text, // John Doe
      'id': idController.text
    }).then((value) {
      print("Category Updated");
      navService.pop();
      DialogUtil.showSnackBar(context, "Category updated successfully");
    }).catchError((error) {
      print("Failed to add user: $error");
      navService.pop();
    });


    ref.read(selectedCategoryProvider.notifier).updateCategory(Category(docId: catId, id: idController.text, name: nameController.text, color: Colors.green));
  }
}

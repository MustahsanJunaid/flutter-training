import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training/dialog/dialog_util.dart';
import 'package:training/model/category.dart';
import 'package:training/network/result.dart';
import 'package:training/providers/create_category_provider.dart';
import 'package:training/screens/home/categories.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategory();
}

class _CreateCategory extends State<CreateCategory> {
  final nameController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(createCategoryListProvider);
    // if(state is Loading){
    //   if((state as Loading).isLoading) {
    //     DialogUtil.showLoading(context);
    //   }else{
    //     navService.pop();
    //   }
    // }else if(state is Failure){
    //   DialogUtil.showSnackBar(context, (state as Failure).exception.toString());
    // }else if(state is Success){
    //   navService.pop();
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Category"),
          //backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(createCategoryListProvider);
            if (state == null) {
              return Padding(
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
                      text: "Create",
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              );
            } else if (state.state is Failure) {
              print("Failure");
              return Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Failed to create Category"),
                  ElevatedButton(onPressed: () => ref.read(createCategoryListProvider.notifier).reset(), child: Text("Retry"))
                ],
              ));
            } else if(state.state is Loading) {
              print("Loading");
              return const Center(child: CircularProgressIndicator());
            }else {
              print("Success");
              navService.pop();
              return const Center(child: Text("Success"));
            }
          },
        ));
  }

  void onSubmit(BuildContext context, WidgetRef ref) => createCategory(context, ref);

  void createCategory(BuildContext context, WidgetRef ref) {
    ref.read(createCategoryListProvider.notifier).create(Category(id: idController.text, name: nameController.text));

    // DialogUtil.showLoading(context, content: 'Creating Category');
    // final user = FirebaseAuth.instance.currentUser!;
    // CollectionReference category = FirebaseFirestore.instance.collection('categories-${user.uid}');
    // category.add({
    //   'name': nameController.text, // John Doe
    //   'id': idController.text
    // }).then((value) {
    //   print("Category Added");
    //   navService.pop();
    //   DialogUtil.showSnackBar(context, "Category created successfully");
    // }).catchError((error) {
    //   print("Failed to add user: $error");
    //   navService.pop();
    // });
  }
}

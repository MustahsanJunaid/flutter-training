import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../dialog/dialog_util.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() {
    return _UserProfile();
  }
}

class _UserProfile extends State<UserProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  String emailAddress = "";
  String name = "";

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    emailAddress = user?.email ?? "";
    name = user?.displayName ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = emailAddress;
    nameController.text = name;
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Profile"),
          //backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 26),
              MyTextField(
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hint: 'Email Address',
              ),
              const SizedBox(height: 8),
              MyTextField(
                controller: nameController,
                hint: 'Display Name',
              ),
              const SizedBox(height: 8),
              MyButton(
                onTap: () {
                  updateUser(() {
                    DialogUtil.showSnackBar(context, 'Profile Updates');
                  });
                },
                text: 'Update',
              ),
            ],
          ),
        ));
  }

  void updateUser(Function callback) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(nameController.text);
    callback();
  }
}

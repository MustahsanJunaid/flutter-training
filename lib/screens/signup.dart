import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';
import 'package:training/components/blur_container.dart';
import 'package:training/components/my_text_field.dart';
import 'package:training/di/locator.dart';
import 'package:training/navigation/navigation_service.dart';
import 'package:training/navigation/routes.dart';
import '../components/my_button.dart';
import '../dialog/dialog_util.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final NavigationService navService = locator<NavigationService>();

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            navService.goBack();
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.30),
        const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 40)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        BlurContainer(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Look like you don't have an account. Let's create a new one",
                      // ignore: prefer_const_constructors
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.start),
                  // ignore: prefer_const_constructors
                  const SizedBox(height: 30),

                  MyTextField(
                    controller: emailController,
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hint: 'Password',
                    obscureText: true,
                    showToggleIcon: true,
                  ),
                  const SizedBox(height: 30),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                              text: 'By selecting Agree & Continue below, I agree to our ',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            TextSpan(
                                text: 'Terms of Service and Privacy Policy',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 71, 233, 133),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      MyButtonAgree(
                        text: "Agree and Continue",
                        onTap: () {
                          createUser(context, emailController.text, passwordController.text);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void createUser(BuildContext context, String email, password) async {
    if (_formKey.currentState!.validate()) {
      DialogUtil.showLoading(context);
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        navService.goBack();
        navService.replaceToByClearingStack(Routes.category);
      }).catchError((error, stackTrace) {
        navService.goBack();
        String errorMessage = "Please input correct credentials";
        DialogUtil.showSnackBar(context, errorMessage);
      });
    }
  }
}

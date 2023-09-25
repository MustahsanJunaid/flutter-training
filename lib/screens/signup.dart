import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';
import 'package:training/components/blur_container.dart';
import 'package:training/components/my_text_field.dart';
import '../components/my_button.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
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
            Navigator.pop(context);
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.26),
        const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
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
                    controller: usernameController,
                    hint: 'Email',
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
                      const SizedBox(height: 10),
                      MyButtonAgree(
                        text: "Agree and Continue",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
}

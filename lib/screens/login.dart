
import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';
import 'package:training/components/my_text_field.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.28),
        const Text('Login', style: TextStyle(color: Colors.white,fontSize: 30)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        const MyTextField(
          hint: "Email",
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        const MyTextField(
          hint: "Password",
          obscureText: true,
          showToggleIcon: true,
        )
      ]
    );
  }
}
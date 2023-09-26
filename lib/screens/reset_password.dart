import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';
import 'package:training/components/blur_container.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/my_text_field.dart';
import 'package:training/navigation/navigation_service.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        SizedBox(height: MediaQuery.of(context).size.height * 0.30),
        const Text('Reset Password', style: TextStyle(color: Colors.white, fontSize: 40)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        BlurContainer(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextField(
                    hint: "Email",
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                    controller: emailController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  MyButtonAgree(
                    onTap: () => signUserIn(context, emailController.text),
                    text: "Reset Password",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? validateEmail(String? input) {
    if (input!.isEmpty) {
      return 'Input is required';
    } else if (!EmailValidator.validate(input)) {
      return 'Given input is not valid email';
    } else {
      return null;
    }
  }

  void signUserIn(BuildContext context, String email) async {
    if (_formKey.currentState!.validate()) {
      String? result = await _showDialog(
        context,
        "Confirm Email Address",
        "Please confirm if we can send reset link to this email $email",
        [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Change'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, "Reset");
            },
            child: const Text('OK'),
          ),
        ],
      );
      if(result == 'Reset'){
        NavigationService().goBack();
      }
      print(' valid');
    } else {
      print('not valid');
    }
  }

  Future<String?> _showDialog(BuildContext context, String title, String content, List<Widget> actions) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions,
      ),
    );
  }
}

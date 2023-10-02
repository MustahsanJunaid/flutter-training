import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';
import 'package:training/components/blur_container.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/my_text_field.dart';
import 'package:training/di/locator.dart';
import 'package:training/dialog/dialog_util.dart';
import 'package:training/navigation/navigation_service.dart';
import 'package:training/navigation/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final NavigationService navService = locator<NavigationService>();

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.40),
        const Text('Login', style: TextStyle(color: Colors.white, fontSize: 40)),
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
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  MyTextField(
                    hint: "Password",
                    obscureText: true,
                    showToggleIcon: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => {signUserIn(context, emailController.text, passwordController.text)},
                    validator: validatePassword,
                    controller: passwordController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  MyButtonAgree(
                    onTap: () => signUserIn(context, emailController.text, passwordController.text),
                    text: "Login",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 233, 133), fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                      onTap: () => navService.navigateTo(Routes.resetPassword),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => navService.navigateTo(Routes.signup),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  )
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

  String? validatePassword(String? input) {
    if (input!.length < 6) {
      return 'Valid password is required';
    } else {
      return null;
    }
  }

  void signUserIn(BuildContext context, String email, password) async {
    if (_formKey.currentState!.validate()) {
      DialogUtil.showLoading(context, content: 'Singing in');
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
        navService.replaceToByClearingStack(Routes.home);
      }).catchError((error, stackTrace) {
        navService.pop();
        String errorMessage = "";
        if (error.code == 'wrong-password') {
          errorMessage = "Please input correct password";
        } else {
          errorMessage = "Please input correct credentials";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      });
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

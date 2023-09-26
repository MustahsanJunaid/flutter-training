import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';
import 'package:training/components/blur_container.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/my_text_field.dart';
import 'package:training/navigation/navigation_service.dart';
import 'package:training/screens/home.dart';
import 'package:training/screens/reset_password.dart';
import 'package:training/screens/signup.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final navService = NavigationService();

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      children: [
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.40),
        const Text('Login', style: TextStyle(color: Colors.white, fontSize: 40)),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.04),
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
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),
                  MyTextField(
                    hint: "Password",
                    obscureText: true,
                    showToggleIcon: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => {},
                    validator: validatePassword,
                    controller: passwordController,
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),
                  MyButtonAgree(
                    onTap: () => signUserIn(context, emailController.text),
                    text: "Login",
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 233, 133), fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                        );
                        // navService.navigateTo('/reset_password');
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03),
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
                        onTap: () =>
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          )
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 233, 133), fontWeight: FontWeight.bold, fontSize: 20),
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

  void signUserIn(BuildContext context, String email) async {
    if (_formKey.currentState!.validate()) {
      String? result = await _showDialog(
        context,
        "Login Successful",
        "Congratulations, you've successfully logged into futuristic application",
        [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, "Okay");
            },
            child: const Text('OK'),
          ),
        ],
      );
      if (result == 'Okay') {
        navService.navigateTo('/home', arguments: email);
      }
      print(' valid');
    } else {
      print('not valid');
    }
  }

  Future<String?> _showDialog(BuildContext context, String title, String content, List<Widget> actions) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions,
          ),
    );
  }
}

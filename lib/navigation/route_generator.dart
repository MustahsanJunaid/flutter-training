import 'package:flutter/material.dart';
import 'package:training/screens/home.dart';
import 'package:training/screens/login.dart';
import 'package:training/screens/reset_password.dart';
import 'package:training/screens/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (context) => Signup());
      case '/reset_password':
        return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen(email: settings.arguments as String?));

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("Not found ${settings.name}"),
            ),
          ),
        );
    }
  }
}

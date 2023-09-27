import 'package:flutter/material.dart';
import 'package:training/navigation/routes.dart';
import 'package:training/screens/home.dart';
import 'package:training/screens/login.dart';
import 'package:training/screens/reset_password.dart';
import 'package:training/screens/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (Routes.values.byName(settings.name ?? '')) {
      case Routes.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (context) => Signup());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
      case Routes.category:
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

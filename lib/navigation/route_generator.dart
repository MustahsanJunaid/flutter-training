import 'package:flutter/material.dart';
import 'package:training/navigation/routes.dart';
import 'package:training/screens/create_category.dart';
import 'package:training/screens/home.dart';
import 'package:training/screens/login.dart';
import 'package:training/screens/reset_password.dart';
import 'package:training/screens/signup.dart';
import 'package:training/screens/user_profile.dart';

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
      case Routes.createCategory:
        return MaterialPageRoute(builder: (context) => CreateCategory());
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => const UserProfile());

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

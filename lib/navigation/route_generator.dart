import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:training/model/category.dart';
import 'package:training/navigation/routes.dart';
import 'package:training/screens/create_category.dart';
import 'package:training/screens/home/categories.dart';
import 'package:training/screens/home/home.dart';
import 'package:training/screens/login.dart';
import 'package:training/screens/reset_password.dart';
import 'package:training/screens/signup.dart';
import 'package:training/screens/update_category.dart';
import 'package:training/screens/user_profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (Routes.values.byName(settings.name ?? '')) {
      case Routes.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (context) => Signup());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
      case Routes.createCategory:
        return MaterialPageRoute(builder: (context) => CreateCategory());
      case Routes.updateCategory:
        return MaterialPageRoute(
          builder: (context) => UpdateCategory(existingCategory: settings.arguments as Category?),
        );
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => const UserProfile());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                "Not found ${settings.name}",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          ),
        );
    }
  }
}

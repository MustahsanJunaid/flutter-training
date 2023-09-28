import 'package:flutter/material.dart';
import 'package:training/di/locator.dart';
import 'package:training/navigation/navigation_service.dart';
import 'package:training/navigation/route_generator.dart';
import 'package:training/navigation/routes.dart';
import 'package:training/screens/splash_screen.dart';
import 'package:training/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

void main() async {
  setupLocator();
  runApp(SplashApp(
    onInitializationComplete: () {
      runMainApp();
    },
  ));
}

void runMainApp() {
  runApp(MaterialApp(
    title: "Training Application",
    theme: theme,
    debugShowCheckedModeBanner: true,
    onGenerateRoute: RouteGenerator.generateRoutes,
    navigatorKey: locator<NavigationService>().navigatorKey,
    initialRoute: auth.currentUser == null ? Routes.login.name : Routes.category.name,
  ));
}

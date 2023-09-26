import 'package:flutter/material.dart';
import 'package:training/di/locator.dart';
import 'package:training/navigation/navigation_service.dart';
import 'package:training/navigation/route_generator.dart';
import 'package:training/theme/theme.dart';

void main() {
  setupLocator();
  runApp(MaterialApp(
    title: "Training Application",
    theme: theme,
    debugShowCheckedModeBanner: true,
    onGenerateRoute: RouteGenerator.generateRoutes,
    navigatorKey: locator<NavigationService>().navigatorKey,
    initialRoute: "/",
  ));
}

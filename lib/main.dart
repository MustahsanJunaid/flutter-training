import 'package:flutter/material.dart';
import 'package:training/navigation/navigation_service.dart';
import 'package:training/navigation/route_generator.dart';
import 'package:training/screens/login.dart';

void main() {

  runApp(MaterialApp(
    title: "Training Application",
    debugShowCheckedModeBanner: true,
    onGenerateRoute: RouteGenerator.generateRoutes,
    navigatorKey: NavigationService().navigatorKey,
    initialRoute: '/',
  ));


}


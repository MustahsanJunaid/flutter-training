import 'package:flutter/material.dart';

class NavigationService{
  final navigatorKey = GlobalKey<NavigatorState>();

  dynamic navigateTo(String routName, {Object? arguments}){
    return navigatorKey.currentState?.pushNamed(routName, arguments: arguments);
  }

  dynamic replaceTo(String routName, {Object? arguments}){
    return navigatorKey.currentState?.pushReplacementNamed(routName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
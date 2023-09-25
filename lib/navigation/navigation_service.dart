import 'package:flutter/material.dart';

class NavigationService{
  final navigatorKey = GlobalKey<NavigatorState>();

  dynamic navigateTo(String routName, {Object? arguments}){
    return navigatorKey.currentState?.pushNamed(routName, arguments: arguments);
  }

  dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }
}
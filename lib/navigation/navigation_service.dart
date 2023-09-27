import 'package:flutter/material.dart';
import 'package:training/navigation/routes.dart';

class NavigationService{
  final navigatorKey = GlobalKey<NavigatorState>();

  dynamic navigateTo(Routes route, {Object? arguments}){
    return navigatorKey.currentState?.pushNamed(route.name, arguments: arguments);
  }

  dynamic replaceTo(Routes route, {Object? arguments}){
    return navigatorKey.currentState?.pushReplacementNamed(arguments: arguments, route.name);
  }

  dynamic replaceToByClearingStack(Routes route, {Object? arguments}){
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(route.name, (route) => false, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
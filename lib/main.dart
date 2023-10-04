import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/di/locator.dart';
import 'package:training/navigation/navigation_service.dart';
import 'package:training/navigation/route_generator.dart';
import 'package:training/navigation/routes.dart';
import 'package:training/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training/theme/training_adaptive_theme.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(SplashApp(
    savedThemeMode: savedThemeMode,
    onInitializationComplete: () {
      runMainApp();
    },
  ));
}

void runMainApp() async {
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(
    child: _App(
      savedThemeMode: savedThemeMode,
    ),
  ));
}

class _App extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const _App({required this.savedThemeMode});

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return TrainingAdaptiveTheme(
      savedThemeMode: widget.savedThemeMode,
      builder: (lightTheme, darkTheme) => MaterialApp(
        title: "Training Application",
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: true,
        onGenerateRoute: RouteGenerator.generateRoutes,
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: auth.currentUser == null ? Routes.login.name : Routes.home.name,
      ),
    );
  }
}

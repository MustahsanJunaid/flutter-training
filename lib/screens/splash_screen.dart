import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';

import '../firebase_options.dart';
import '../theme/training_adaptive_theme.dart';

final auth = FirebaseAuth.instance;

class SplashApp extends StatefulWidget {
  const SplashApp({
    super.key,
    required this.onInitializationComplete,
    this.savedThemeMode,
  });

  final VoidCallback onInitializationComplete;
  final AdaptiveThemeMode? savedThemeMode;

  @override
  State<SplashApp> createState() {
    return SplashAppState();
  }
}

class SplashAppState extends State<SplashApp> {
  var hasError = false;

  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TrainingAdaptiveTheme(
      savedThemeMode: widget.savedThemeMode,
      builder: (lightTheme, darkTheme) => MaterialApp(
        title: "Training Application",
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: true,
        home: AuthContainer(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Text(
                  "Hold on a second please...",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    widget.onInitializationComplete();
  }
}

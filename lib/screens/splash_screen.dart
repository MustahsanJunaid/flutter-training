import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training/components/auth_container.dart';

import '../firebase_options.dart';
import '../theme/theme.dart';

final auth = FirebaseAuth.instance;

class SplashApp extends StatefulWidget {
  const SplashApp({super.key, required this.onInitializationComplete});

  final VoidCallback onInitializationComplete;

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
    return MaterialApp(
      title: "Training Application",
      theme: theme,
      debugShowCheckedModeBanner: true,
      home: const AuthContainer(children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text("Hold on a second please..."),
          ],
        ),
      ]),
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

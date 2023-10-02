import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:training/theme/theme.dart';

class TrainingAdaptiveTheme extends StatelessWidget {
  const TrainingAdaptiveTheme({super.key, required this.builder, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  final AdaptiveThemeBuilder builder;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: TrainingTheme.light,
      dark: TrainingTheme.dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: builder,
    );
  }
}

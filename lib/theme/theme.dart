import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 71, 233, 133),
        brightness: Brightness.light,
      ),
      brightness: Brightness.light,
      // appBarTheme: const AppBarTheme().copyWith(
      //   backgroundColor: kColorScheme.onPrimaryContainer,
      //   foregroundColor: kColorScheme.primaryContainer,
      // ),
      textTheme: GoogleFonts.latoTextTheme(),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 71, 233, 133),
        brightness: Brightness.dark,
      ),
      // appBarTheme: const AppBarTheme().copyWith(
      //   backgroundColor: kColorScheme.onPrimaryContainer,
      //   foregroundColor: kColorScheme.primaryContainer,
      // ),
      textTheme: GoogleFonts.latoTextTheme(),
    );
  }
}


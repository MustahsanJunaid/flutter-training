import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 71, 233, 133));
var kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 32, 54, 33));

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);


final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: kDarkColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

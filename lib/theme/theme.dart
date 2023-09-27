import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color appColor = const Color.fromARGB(255, 71, 233, 133);

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: appColor,
    ),
  textTheme: GoogleFonts.latoTextTheme()
);

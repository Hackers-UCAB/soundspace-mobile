import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodySmall:
              GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 17),
          bodyLarge:
              GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 24),
          bodyMedium:
              GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 18),
        ),
      );
}
